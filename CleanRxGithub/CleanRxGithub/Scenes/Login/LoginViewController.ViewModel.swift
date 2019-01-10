//
// Created by Arnon Keereena on 23/12/2018 AD.
// Copyright (c) 2018 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import GithubDomain

extension LoginViewController {
  final class ViewModel: ViewModelType {
    struct Input {
      var username: Driver<String>
      var password: Driver<String>
      var loginTrigger: Driver<Void>
    }
    
    struct Output {
      var loggedIn: Driver<UserSession>
      var loggingIn: Driver<Bool>
      var error: Driver<Error>
    }
    
    var useCase: AuthenticationUseCase
    var navigator: LoginNavigator
    
    init(useCase: AuthenticationUseCase,
         navigator: LoginNavigator) {
      self.useCase = useCase
      self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
      let loggingIn = ActivityIndicator()
      let error = ErrorTracker()
      let loggedIn = input.loginTrigger
        .flatMapLatest { Driver.combineLatest(input.username, input.password) }
        .flatMapLatest {
          self.useCase.login(username: $0.0, password: $0.1, scopes: ["public_repo"], note: "CleanRxGithub")
                      .trackActivity(loggingIn)
                      .trackError(error)
                      .observeOn(ConcurrentMainScheduler.instance)
                      .subscribeOn(MainScheduler.instance)
                      .asDriverOnErrorJustComplete()
        }
        .do(onNext: { _ in self.navigator.toHome() })
      
      return Output(loggedIn: loggedIn.debug("out:ok"),
                    loggingIn: loggingIn.debug("out:activity").asDriver(),
                    error: error.debug("out:error").asDriver())
    }
  }
}
