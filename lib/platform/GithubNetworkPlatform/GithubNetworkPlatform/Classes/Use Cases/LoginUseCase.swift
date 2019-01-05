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
  
  func login(username: String, password: String) -> Single<Void> {
    return network.rx
      .request(.login(username: username, password: password))
      .map {
        if let error = $0.error {
          throw error
        } else {
          return ()
        }
      }
  }
}

