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
  
  static var cache: LoginResponse? {
    get {
      return UserDefaults.standard.string(forKey: "LoginResponse_Cache")
                                  .flatMap { LoginResponse(JSONString: $0) }
    }
    set {
      let json = newValue?.toJSONString() ?? "{}"
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
    if let cache = AuthenticationUseCase.cache {
      return Single.just(cache)
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
      .do(onSuccess: { AuthenticationUseCase.cache = $0 })
      .map(UserSession.init(loginResponse:))
      .do(onSuccess: { AuthenticationUseCase.currentUserSession = $0 })
  }
  
  func logout() -> Single<Void> {
    AuthenticationUseCase.currentUserSession = nil
    return .just(())
  }
  
  func recoverUserSession() -> Single<UserSession?> {
    // In memory recovering is preferred to disk recovering
    return .just(AuthenticationUseCase.currentUserSession ??
                 AuthenticationUseCase.cache.flatMap { try? UserSession(loginResponse: $0) })
  }
}

