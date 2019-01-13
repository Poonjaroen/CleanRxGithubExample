//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import GithubDomain
import GithubNetwork
import Moya

public final class UseCaseProvider: GithubDomain.UseCaseProvider {
  
  private var networkProvider: Provider {
    return Provider(plugins: [NetworkLoggerPlugin(verbose: true)])
  }
  
  public init() {}
  
  public func makeAuthenticationUseCase() -> GithubDomain.AuthenticationUseCase {
    return AuthenticationUseCase(network: networkProvider)
  }
  
  public func makeProfileUseCase(session: UserSession) -> GithubDomain.ProfileUseCase {
    return ProfileUseCase(session: session, network: networkProvider)
  }
  
  public func makeRepoUseCase(session: UserSession) -> GithubDomain.RepoUseCase {
    return RepoUseCase(session: session, network: networkProvider)
  }
}
