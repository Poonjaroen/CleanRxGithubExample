//
// Created by Arnon Keereena on 23/12/2018 AD.
// Copyright (c) 2018 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit
import GithubDomain
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var profileImageView: UIImageView?
  @IBOutlet weak var nameLabel: UILabel?
  
  // MARK: - Rx
  
  let viewModel: ViewModel!
  let disposeBag = DisposeBag()
  
  // MARK: - Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rxBinding()
  }
  
  func rxBinding() {
    ensureViewModel()
    let output = viewModel.transform(input: .init())

// NOTE: Functional!!!
//    profileImageView.flatMap {
//      output.profileImage.drive($0.rx.image)
//    }
//
//    nameLabel.flatMap {
//      Drive.zip(output.firstName, output.lastName) { "\($0) \($1)" }
//           .drive($0.rx.text)
//    }
//
// NOTE: The same one as above but shorten to one line
//    profileImageView.flatMap { output.profileImage.drive($0.rx.image) }
//    nameLabel.flatMap { Drive.zip(output.firstName, output.lastName) { "\($0) \($1)" }.drive($0.rx.text) }
    
    if let imageView = profileImageView {
      output.profileImage.drive(imageView.rx.image)
    }
    
    if let label = nameLabel {
      Drive.zip(output.firstName, output.lastName) { "\($0) \($1)" }
           .drive(label.rx.text)
    }
  }
  
  private func ensureViewModel() {
    guard viewModel == nil else { return }
    let stb = UIStoryboard(name: "Main", bundle: nil)
    let useCase = AppDelegate.useCaseProvider.makeProfileUseCase()
    let navigator = DefaultProfileNavigator(provider: AppDelegate.useCaseProvider,
                                            sourceViewController: self,
                                            storyboard: stb)
    viewModel = ViewModel(useCase: useCase, navigator: navigator)
  }
}