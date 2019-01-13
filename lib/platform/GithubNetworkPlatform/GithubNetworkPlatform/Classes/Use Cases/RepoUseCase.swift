//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation
import GithubDomain
import GithubNetwork
import RxSwift

public final class RepoUseCase: GithubDomain.RepoUseCase {
  
  let session: UserSession
  var network: Provider!
  
  public convenience init(session: UserSession, network: Provider) {
    self.init(session: session)
    self.network = network
  }
  
  public required init(session: UserSession) {
    self.session = session
    self.network = .init()
  }
  
  public func myRepo() -> Single<SearchRepoResponse> {
    return .just(.init())
  }
  
  public func search(request: SearchRepoRequest) -> Single<SearchRepoResponse> {
    return network.rx.request(.searchRepo(request: request))
                     .map { try $0.toModel(SearchRepoResponse.self) }
  }
}