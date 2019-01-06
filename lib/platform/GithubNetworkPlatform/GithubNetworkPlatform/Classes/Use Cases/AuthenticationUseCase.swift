//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import GithubDomain
import GithubNetwork
import RxSwift
import Moya

final class LoginUseCase: GithubDomain.AuthenticationUseCase {
  let network: Provider
  
  init(network: Provider) {
    self.network = network
  }
  
  func login(username: String,
             password: String,
             scopes: [String] = ["public_repo"],
             note: String? = nil) -> Single<UserSession> {
    let  request = LoginRequest(username: username,
                                password: password,
                                scopes: scopes,
                                note: note)
    return network.rx
      .request(.login(request: request))
      .map {
        if let error = $0.error {
          throw error
        } else {
          return ()
        }
      }
  }
  
  func logout() -> Single<Void> {
  
  }
  
  func recoverUserSession() -> Single<UserSession> {
  
  }
}

