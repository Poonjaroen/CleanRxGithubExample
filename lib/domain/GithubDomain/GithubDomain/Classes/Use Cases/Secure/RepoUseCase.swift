//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation
import RxSwift

public protocol RepoUseCase {
  init(session: UserSession)
  
  func myRepo() -> Single<SearchRepoResponse>
  
  func search(request: SearchRepoRequest) -> Single<SearchRepoResponse>
}