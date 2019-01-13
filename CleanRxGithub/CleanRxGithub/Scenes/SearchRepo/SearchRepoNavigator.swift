//
// Created by Arnon Keereena on 13/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import GithubDomain
import UIKit

protocol SearchRepoNavigator {
  func toRepoDetail()
}

class DefaultSearchRepoNavigator: SearchRepoNavigator {
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
  
  func toRepoDetail() {
  }
}