//
// Created by Arnon Keereena on 11/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import GithubDomain
import RxSwift
import RxCocoa

extension ProfileViewController {
  final class ViewModel: ViewModelType {
    struct Input {
      var logoutTrigger: Driver<Void>
    }
    
    struct Output {
      var profileImage: Driver<UIImage?>
      var profileUrl: Driver<String?>
      var fullName: Driver<String?>
      var logout: Driver<Void>
      var loadingProfile: Driver<Bool>
      var loggingOut: Driver<Bool>
    }
    
    var profileUseCase: ProfileUseCase
    var authenticationUseCase: AuthenticationUseCase
    var navigator: ProfileNavigator
    
    init(profileUseCase: ProfileUseCase,
         authenticationUseCase: AuthenticationUseCase,
         navigator: ProfileNavigator) {
      self.profileUseCase = profileUseCase
      self.authenticationUseCase = authenticationUseCase
      self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
      let loadingProfile = ActivityIndicator()
      let loggingOut = ActivityIndicator()
      
      let userProfile = profileUseCase.myProfile()
                                      .trackActivity(loadingProfile)
      
      let profileImage = userProfile.map { profile -> UIImage? in
        guard let urlString = profile?.avatarUrl,
              let url = URL(string: urlString) else { return nil }
        let data = try Data(contentsOf: url)
        return UIImage(data: data)
      }
      
      let profileUrl = userProfile.map { $0?.url }
      
      let fullName = userProfile.map { $0?.name }
      
      let logout = input.logoutTrigger
        .flatMap { _ in self.authenticationUseCase.logout().asDriver(onErrorJustReturn: ()) }
        .do(onNext: { self.navigator.toLogin() })
        .trackActivity(loggingOut)
      
      return Output.init(
        profileImage: profileImage.asDriver(onErrorJustReturn: nil),
        profileUrl: profileUrl.asDriver(onErrorJustReturn: nil),
        fullName: fullName.asDriver(onErrorJustReturn: nil),
        logout: logout.asDriver(onErrorJustReturn: ()),
        loadingProfile: loadingProfile.asDriver(),
        loggingOut: loggingOut.asDriver()
      )
    }
  }
}

