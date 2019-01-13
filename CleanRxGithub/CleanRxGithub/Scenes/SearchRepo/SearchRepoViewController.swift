//
// Created by Arnon Keereena on 23/12/2018 AD.
// Copyright (c) 2018 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit
import GithubDomain
import RxSwift
import RxCocoa

class SearchRepoViewController: UIViewController {
  
  // MARK: - Rx
  
  let disposeBag = DisposeBag()
  var viewModel: ViewModel!
  
  // MARK: - Outlets
  
  @IBOutlet weak var searchTextField: UITextField?
  @IBOutlet weak var tableView: UITableView?
  
  // MARK: - Cycles
  
  override func viewDidLoad() {
    setupUI()
    super.viewDidLoad()
    rxBinding()
  }
  
  // MARK: - Setting up
  
  private func setupUI() {
    tableView?.estimatedRowHeight = 100
    tableView?.rowHeight = UITableView.automaticDimension
    tableView?.tableFooterView = UIView()
  }
  
  func rxBinding() {
    _ = ensureViewModel().subscribe(onSuccess: { [weak self] in
      guard let _self = self,
            let textField = _self.searchTextField,
            let tableView = _self.tableView else { return }
      let query = textField.rx.text.asDriver(onErrorJustReturn: nil)
      let output = _self.viewModel.transform(input: .init(query: query))
      output.repos.drive(tableView.rx.items(cellIdentifier: "RepoCell",
                                            cellType: RepoCell.self)) { (row, model, cell) in
        cell.repoName = model.fullName
        cell.author = model.owner?.login
        cell.authorAvatarUrl = model.owner?.avatarUrl
      }
    })
  }
  
  private func ensureViewModel() -> Single<Void> {
    guard viewModel == nil else { return Single.error(InternalError()) }
    return AppDelegate.useCaseProvider
      .makeAuthenticationUseCase()
      .recoverUserSession()
      .map { [weak self] session in
        guard let _self = self, let session = session else { throw InternalError() }
        let stb = UIStoryboard(name: "Main", bundle: nil)
        let useCase = AppDelegate.useCaseProvider.makeRepoUseCase(session: session)
        let navigator = DefaultSearchRepoNavigator(provider: AppDelegate.useCaseProvider,
                                                   sourceViewController: _self,
                                                   storyboard: stb)
        _self.viewModel = ViewModel(useCase: useCase, navigator: navigator)
        return
      }
  }
  
}