//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import GithubDomain
import GithubNetwork

public final class UseCaseProvider: GithubDomain.UseCaseProvider {
  
  public init() {}
  
  public func makeLoginUseCase() -> GithubDomain.LoginUseCase {
    return LoginUseCase(network: Provider())
  }
}
