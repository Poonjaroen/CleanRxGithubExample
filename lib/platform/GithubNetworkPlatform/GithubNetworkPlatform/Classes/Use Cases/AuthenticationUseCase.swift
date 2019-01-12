//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import GithubDomain
import GithubNetwork
import RxSwift
import Moya

extension Single {
  static func justOrEmpty(_ element: Element?) -> Single<Element> {
    return element.flatMap { Single.just($0) } ?? Observable.empty().asSingle()
  }
}

final class AuthenticationUseCase: GithubDomain.AuthenticationUseCase {
  let network: Provider
  
  static var currentUserSession: UserSession? = nil
  
  static var usernameCache: String? {
    get { return UserDefaults.standard.string(forKey: "Username_Cache") }
    set { UserDefaults.standard.set(newValue, forKey: "Username_Cache") }
  }
  
  static var passwordCache: String? {
    get { return UserDefaults.standard.string(forKey: "Password_Cache") }
    set { UserDefaults.standard.set(newValue, forKey: "Password_Cache") }
  }
  
  static var loginResponseCache: LoginResponse? {
    get {
      return UserDefaults.standard.string(forKey: "LoginResponse_Cache")
                                  .flatMap { LoginResponse(JSONString: $0) }
    }
    set {
      guard let json = newValue?.toJSONString() else {
        UserDefaults.standard.set(nil, forKey: "LoginResponse_Cache")
        return
      }
      print("Storing json", json)
      UserDefaults.standard.set(json, forKey: "LoginResponse_Cache")
    }
  }
  
  init(network: Provider) {
    self.network = network
  }
  
  private func loginResponse(username: String,
                             password: String,
                             scopes: [String],
                             note: String?) -> Single<LoginResponse> {
    if let cache = AuthenticationUseCase.loginResponseCache {
      if cache.id == nil {
        return Single.error(InternalError())
      } else {
        return Single.just(cache)
      }
    } else {
      return network.rx
        .request(.login(request: LoginRequest(username: username, password: password, scopes: scopes, note: note)))
        .flatMap { Single.justOrEmpty($0.toModel(LoginResponse.self)) }
    }
  }
  
  
  func login(username: String,
             password: String,
             scopes: [String] = ["public_repo"],
             note: String? = nil) -> Single<UserSession> {
    return loginResponse(username: username, password: password, scopes: scopes, note: note)
      .map { ($0, username, password) }
      .do(onSuccess: {
        AuthenticationUseCase.loginResponseCache = $0.0
        AuthenticationUseCase.usernameCache = $0.1
        AuthenticationUseCase.passwordCache = $0.2
      }, onError: { _ in
        AuthenticationUseCase.clearCaches()
      })
      .map { ($0.0, $0.1) }
      .map(UserSession.init(loginResponse:username:))
      .do(onSuccess: { AuthenticationUseCase.currentUserSession = $0 })
  }
  
  func logout() -> Single<Void> {
    guard let id = AuthenticationUseCase.loginResponseCache?.id,
          let username = AuthenticationUseCase.usernameCache,
          let password = AuthenticationUseCase.passwordCache else {
      return .just(())
    }
    return network.rx.request(.deletePAT(id: id, username: username, password: password))
                     .debug("deletePAT")
                     .do(onSuccess: { _ in AuthenticationUseCase.currentUserSession = nil })
                     .do(onSuccess: { _ in AuthenticationUseCase.clearCaches() })
                     .map { _ in }
  }
  
  private class func clearCaches() {
    loginResponseCache = nil
    usernameCache = nil
    passwordCache = nil
  }
  
  func recoverUserSession() -> Single<UserSession?> {
    // In memory recovering is preferred to disk recovering
    let fromMemory = AuthenticationUseCase.currentUserSession
    let fromCache = AuthenticationUseCase.loginResponseCache.selectWith(
      AuthenticationUseCase.usernameCache,
      selector: { try? UserSession.init(loginResponse: $0, username: $1) }
    )
    let maybeSession = fromMemory ?? fromCache
    maybeSession.flatMap {
      AuthenticationUseCase.currentUserSession = $0
    }
    return .just(maybeSession)
  }
}

extension Optional {
  func selectWith<T, R>(_ anotherOptional: Optional<T>, selector: (Wrapped, T) -> R?) -> R? {
    return self.flatMap { left in
      anotherOptional.flatMap { right in selector(left, right) }
    }
  }
}
