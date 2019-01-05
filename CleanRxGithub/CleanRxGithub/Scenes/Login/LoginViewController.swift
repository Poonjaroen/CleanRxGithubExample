//
//  ViewController.swift
//  CleanRxGithub
//
//  Created by Arnon Keereena on 22/12/2561 BE.
//  Copyright © 2561 Arnon Keereena. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GithubDomain

class LoginViewController: UIViewController {
  
  // MARK: - Rx
  
  var viewModel: ViewModel!
  let disposeBag = DisposeBag()
  
  // MARK: - Outlets
  
  @IBOutlet weak var usernameTextField: UITextField?
  @IBOutlet weak var passwordTextField: UITextField?
  @IBOutlet weak var errorLabel: UILabel?
  @IBOutlet weak var loginButton: UIButton?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    rxBinding()
  }
  
  private func ensureViewModel() {
    guard viewModel == nil else { return }
    let stb = UIStoryboard(name: "Main", bundle: nil)
    let useCase = AppDelegate.useCaseProvider.makeLoginUseCase()
    let navigator = DefaultLoginNavigator(provider: AppDelegate.useCaseProvider, sourceViewController: self, storyboard: stb)
    viewModel = ViewModel(useCase: useCase, navigator: navigator)
  }
  
  private func rxBinding() {
    ensureViewModel()
    guard let username = usernameTextField?.rx.text.filter({ $0 != nil }).map({ $0! }),
          let password = passwordTextField?.rx.text.filter({ $0 != nil }).map({ $0! }),
          let trigger = loginButton?.rx.tap else { return }
    let output = viewModel.transform(
      input: .init(username: username.debug("in:user").asDriverOnErrorJustComplete(),
                   password: password.asDriverOnErrorJustComplete(),
                   loginTrigger: trigger.debug("in:trigger").asDriverOnErrorJustComplete())
    )
    
    output.loggedIn.drive().disposed(by: disposeBag)
    
    output.error.drive(onNext: { [weak self] in
      if let error = $0 as? APIError {
        self?.errorLabel?.text = error.message
      } else {
        self?.errorLabel?.text = $0.localizedDescription
      }
    }).disposed(by: disposeBag)
  }
  
}

