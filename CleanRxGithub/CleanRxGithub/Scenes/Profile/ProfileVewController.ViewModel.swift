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
      init() {}
    }
    
    struct Output {
      var profileImage: Driver<UIImage?>
      var fullName: Driver<String?>
    }
    
    var useCase: ProfileUseCase
    var navigator: ProfileNavigator
    
    init(useCase: ProfileUseCase,
         navigator: ProfileNavigator) {
      self.useCase = useCase
      self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
      let userProfile = useCase.myProfile()
      let profileImage = userProfile.map { profile -> UIImage? in
        guard let urlString = profile?.avatarUrl,
              let url = URL(string: urlString) else { return nil }
        let data = try Data(contentsOf: url)
        return UIImage(data: data)
      }
//      let fullName = userProfile.map { "\($0.firstName) \($0.lastName)" }
      let fullName = userProfile.map { $0?.url }
      return Output.init(
        profileImage: profileImage.asDriver(onErrorJustReturn: nil),
        fullName: fullName.asDriver(onErrorJustReturn: nil)
      )
    }
  }
}

