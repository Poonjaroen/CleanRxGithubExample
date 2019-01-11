//
// Created by Arnon Keereena on 11/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import GithubDomain

protocol ProfileNavigator {
  func placholder()
}

class DefaultProfileNavigator: ProfileNavigator {
  private let storyboard: UIStoryboard
  private let sourceViewController: UIViewController
  private let provider: UseCaseProvider
  
  init(provider: UseCaseProvider,
       sourceViewController: UIViewController,
       storyboard: UIStoryboard) {
    self.provider = provider
    self.sourceViewController = sourceViewController
    self.storyboard = storyboard
  }
  
  func placholder() {
    fatalError("This file is here just for the sake of completeness of the example")
  }
}