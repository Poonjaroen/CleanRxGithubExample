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
  @IBOutlet weak var authorAvatarImageView: UIImageView?
  @IBOutlet weak var authorAvatarActivityIndicator: UIActivityIndicatorView?
  
  // MARK: - Getter setters
  
  var repoName: String? {
    get { return titleLabel?.text }
    set { titleLabel?.text = newValue }
  }
  
  var authorAvatar: UIImage? {
    get { return authorAvatarImageView?.image }
    set { authorAvatarImageView?.image = newValue }
  }
  
  var authorAvatarUrl: String? {
    didSet {
      loadAndDisplayAvatar(authorAvatarUrl)
    }
  }
  
  var author: String? {
    get { return authorLabel?.text }
    set { authorLabel?.text = newValue }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    authorAvatarImageView?.beCircle()
  }
  
  private func loadAndDisplayAvatar(_ urlString: String?) {
    DispatchQueue.global().async { [weak self] in
      self?.displayAuthorAvatar(loading: true)
      let image = urlString
        .flatMap { URL(string: $0) }
        .flatMap { try? Data(contentsOf: $0) }
        .flatMap { UIImage(data: $0) }
      DispatchQueue.main.async {
        self?.authorAvatarImageView?.image = image
        self?.displayAuthorAvatar(loading: false)
      }
    }
  }
  
  private func displayAuthorAvatar(loading: Bool) {
    authorAvatarImageView.selectWith(authorAvatarActivityIndicator) { (imageView, indicator) in
      if loading {
        indicator.startAnimating()
        indicator.fadeIn()
        imageView.fadeOut()
      } else {
        indicator.stopAnimating()
        indicator.fadeOut()
        imageView.fadeIn()
      }
    }
  }
}

extension UIView {
  public func fadeIn(completion: @escaping () -> Void = {}) {
    fade(from: alpha == 1 ? 0 : alpha, to: 1)
  }
  
  public func fadeOut(completion: @escaping () -> Void = {}) {
    fade(from: alpha == 0 ? 1 : alpha, to: 0)
  }
  
  public func fade(from: CGFloat, to: CGFloat, completion: @escaping () -> Void = {}) {
    if alpha == to {
      alpha = from
    }
    UIView.animate(withDuration: 0.2,
                   animations: { () -> Void in self.alpha = to },
                   completion: { _ in completion() })
  }
}