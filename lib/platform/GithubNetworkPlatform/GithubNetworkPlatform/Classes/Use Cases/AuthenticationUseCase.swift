//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import GithubDomain
import GithubNetwork
import RxSwift
import Moya

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
      .mapToModel(LoginResponse.self)
      .map(UserSession.init(loginResponse:))
      .do(onSuccess: { AuthenticationUseCase.currentUserSession = $0 })
  }
  
  func logout() -> Single<Void> {
    AuthenticationUseCase.currentUserSession = nil
    return .just(())
  }
  
  func recoverUserSession() -> Single<UserSession> {
  
  }
}

