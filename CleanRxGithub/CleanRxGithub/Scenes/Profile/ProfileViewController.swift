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
    _ = ensureViewModel().subscribe(onSuccess: { [weak self] in self?.rxBinding() })
  }
  
  func rxBinding() {
    let output = viewModel.transform(input: .init())
    
    // NOTE: Functional!!! If you are interested uncommented this and comment below
    //profileImageView.flatMap {
    //  output.profileImage.drive($0.rx.image)
    //}.disposed(by: disposeBag)
    //
    //nameLabel.flatMap {
    //  Drive.zip(output.firstName, output.lastName) { "\($0) \($1)" }
    //       .drive($0.rx.text)
    //}.disposed(by: disposeBag)
    //
    // NOTE: The same one as above but shorten to one line
    //profileImageView.flatMap { output.profileImage.drive($0.rx.image) }.disposed(by: disposeBag)
    //nameLabel.flatMap { Drive.zip(output.firstName, output.lastName) { "\($0) \($1)" }.drive($0.rx.text) }.disposed(by: disposeBag)
    
    if let imageView = profileImageView {
      output.profileImage.drive(imageView.rx.image)
                         .disposed(by: disposeBag)
    }
    
    if let label = nameLabel {
      output.fullName.drive(label.rx.text)
                     .disposed(by: disposeBag)
    }
  }
  
  private func ensureViewModel() -> Single<Void> {
    guard viewModel == nil else { return Single.error(NetworkError()) }
    return AppDelegate.useCaseProvider
      .makeAuthenticationUseCase()
      .recoverUserSession()
      .map { session in
        guard let session = session else { throw NetworkError() }
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let useCase = AppDelegate.useCaseProvider.makeProfileUseCase(session: session)
        let navigator = DefaultProfileNavigator(provider: AppDelegate.useCaseProvider,
                                                sourceViewController: self,
                                                storyboard: stb)
        viewModel = ViewModel(useCase: useCase, navigator: navigator)
        return
      }
  }
}