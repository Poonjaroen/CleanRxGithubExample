//
// Created by Arnon Keereena on 13/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension SearcRepoViewController {
  final class ViewModel: ViewModelType {
    struct Input {
    
    }
    struct Output {

    }
    
    var useCase: SearcRepoUseCase
    var navigator: SearcRepoNavigator
    
    init(useCase: SearcRepoUseCase,
         navigator: SearcRepoNavigator) {
      self.useCase = useCase
      self.navigator = navigator
    }
  
    func transform(input: Input) -> Output {
    }
  }
}
