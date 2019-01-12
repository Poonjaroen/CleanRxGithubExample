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
  
  @IBOutlet weak var profileImageContainerView: UIView?
  @IBOutlet weak var profileImageView: UIImageView?
  @IBOutlet weak var profileUrlLabel: UILabel?
  @IBOutlet weak var nameLabel: UILabel?
  @IBOutlet weak var logoutButton: UIBarButtonItem?
  @IBOutlet weak var activityIndcatorContainerView: UIView?
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView?
  
  // MARK: - Rx
  
  var viewModel: ViewModel!
  let disposeBag = DisposeBag()
  
  // MARK: - Cycles
  
  override func viewDidLoad() {
    setupUI()
    super.viewDidLoad()
    _ = ensureViewModel().subscribe(onSuccess: { [weak self] in self?.rxBinding() })
  }
  
  private func setupUI() {
    profileImageContainerView.selectWith(profileImageView) { (container, imageView) in
      container.beCircle(masks: false)
      imageView.beCircle()
      container.addShadow(pathLike: imageView, offset: .init(width: -8, height: 16))
    }
    
    activityIndcatorContainerView?.beCircle()
  }
  
  func rxBinding() {
    guard let logoutButton = logoutButton else { return }
    let output = viewModel.transform(input: .init(logoutTrigger: logoutButton.rx.tap.asDriver()))
    
    if let imageView = profileImageView {
      output.profileImage.drive(imageView.rx.image)
                         .disposed(by: disposeBag)
    }
    
    if let label = profileUrlLabel {
      output.profileUrl.drive(label.rx.text)
                       .disposed(by: disposeBag)
    }
    
    if let label = nameLabel {
      output.fullName.drive(label.rx.text)
                     .disposed(by: disposeBag)
    }
    _ = output.loadingProfile
      .asObservable()
      .filter { !$0 }
      .take(1)
      .mapToVoid()
      .subscribe(onNext: { [weak self] in self?.displayProfileLoaded() })
    
    output.logout.drive()
                 .disposed(by: disposeBag)
  }
  
  private func ensureViewModel() -> Single<Void> {
    guard viewModel == nil else { return Single.error(InternalError()) }
    return AppDelegate.useCaseProvider
      .makeAuthenticationUseCase()
      .recoverUserSession()
      .map { [weak self] session in
        guard let _self = self, let session = session else { throw InternalError() }
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
  
  // MARK: - Display
  
  func displayProfileLoaded() {
    activityIndcatorContainerView.selectWith(profileImageView) { (view, imageView) in
      view.animateMagicMove(to: imageView,
                            addOnAnimationsDelay: 0.4,
                            addOnAnimations: { $0.alpha = 0 })
    }
    
    let views = profileImageContainerView.selectWith(profileUrlLabel, nameLabel) { [$0, $1, $2] }
    views?.forEach {
      $0.isHidden = false
      $0.alpha = 0
    }
    UIView.animate(withDuration: 0.4,
                   delay: 0.4,
                   animations: {
                     views?.forEach { $0.alpha = 1 }
                   })
  }
}