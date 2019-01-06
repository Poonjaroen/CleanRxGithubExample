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
  
  init(network: Provider) {
    self.network = network
  }
  
  func login(username: String,
             password: String,
             scopes: [String] = ["public_repo"],
             note: String? = nil) -> Single<UserSession> {
    let request = LoginRequest(username: username,
                               password: password,
                               scopes: scopes,
                               note: note)
    return network.rx
      .request(.login(request: request))
      .flatMap { Single.justOrEmpty($0.toModel(LoginResponse.self)) }
      .map(UserSession.init(loginResponse:))
      .do(onSuccess: { AuthenticationUseCase.currentUserSession = $0 })
  }
  
  func logout() -> Single<Void> {
    AuthenticationUseCase.currentUserSession = nil
    return .just(())
  }
  
  func recoverUserSession() -> Single<UserSession?> {
    return .just(AuthenticationUseCase.currentUserSession)
  }
}

