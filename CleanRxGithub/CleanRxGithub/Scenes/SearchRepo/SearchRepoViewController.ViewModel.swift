//
// Created by Arnon Keereena on 13/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import GithubDomain
import RxSwift
import RxCocoa

extension SearchRepoViewController {
  final class ViewModel: ViewModelType {
    struct Input {
      var query: Driver<String?>
    }
    
    struct Output {
      var repos: Driver<[Repo]>
    }
    
    var useCase: RepoUseCase
    var navigator: SearchRepoNavigator
    
    init(useCase: RepoUseCase,
         navigator: SearchRepoNavigator) {
      self.useCase = useCase
      self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
      let repos = input.query
        .filter { $0 != nil && $0 != "" }
        .map { $0! }
        .debounce(0.25)
        .flatMap {
          self.useCase.search(request: .init(query: $0))
                      .asDriver { _ in Driver.empty() }
        }
        .map { $0.items }
      return Output(repos: repos)
    }
  }
}
