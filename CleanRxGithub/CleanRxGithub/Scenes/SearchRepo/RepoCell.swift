//
// Created by Arnon Keereena on 13/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

class RepoCell: UITableViewCell {
  
  // MARK: - Outlets
  
  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var authorLabel: UILabel?
  
  // MARK: - Getter setters
  
  var repoName: String? {
    get { return titleLabel?.text }
    set { titleLabel?.text = newValue }
  }
  
  var author: String? {
    get { return authorLabel?.text }
    set { authorLabel?.text = newValue }
  }
  
  override func awakeFromNib() { super.awakeFromNib() }
}