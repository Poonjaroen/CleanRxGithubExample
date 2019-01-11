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
  @IBOutlet weak var logoutButton: UIBarButtonItem?
  
  // MARK: - Rx
  
  var viewModel: ViewModel!
  let disposeBag = DisposeBag()
  
  // MARK: - Cycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _ = ensureViewModel().subscribe(onSuccess: { [weak self] in self?.rxBinding() })
  }
  
  func rxBinding() {
    guard let logoutButton = logoutButton else { return }
    let output = viewModel.transform(input: .init(logoutTrigger: logoutButton.rx.tap.asDriver()))
    
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
    
    output.logout.drive().disposed(by: disposeBag)
  }
  
  private func ensureViewModel() -> Single<Void> {
    guard viewModel == nil else { return Single.error(NetworkError()) }
    return AppDelegate.useCaseProvider
      .makeAuthenticationUseCase()
      .recoverUserSession()
      .map { [weak self] session in
        guard let _self = self, let session = session else { throw NetworkError() }
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let profileUseCase = AppDelegate.useCaseProvider.makeProfileUseCase(session: session)
        let authenticationUseCase = AppDelegate.useCaseProvider.makeAuthenticationUseCase()
        let navigator = DefaultProfileNavigator(provider: AppDelegate.useCaseProvider,
                                                sourceViewController: _self,
                                                storyboard: stb)
        _self.viewModel = ViewModel(profileUseCase: profileUseCase,
                                    authenticationUseCase: authenticationUseCase,
                                    navigator: navigator)
        return
      }
  }
}