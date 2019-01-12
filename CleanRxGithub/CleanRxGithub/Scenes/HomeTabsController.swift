//
// Created by Arnon Keereena on 11/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

class HomeTabsController: UITabBarController {
  
  // MARK: - Overrides
  
  override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationItem.hidesBackButton = true
  }
  
}
