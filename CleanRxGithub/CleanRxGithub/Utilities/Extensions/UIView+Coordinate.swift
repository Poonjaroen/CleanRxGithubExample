//
// Created by Arnon Keereena on 12/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func addConstraintsToLocation(of view: UIView) {
    let sides: [NSLayoutConstraint.Attribute] = [.leading, .trailing, .top, .bottom]
    let constraints: [NSLayoutConstraint] = sides.map {
      .init(item: self, attribute: $0, relatedBy: .equal, toItem: view, attribute: $0, multiplier: 1, constant: 0)
    }
    UIApplication.shared.keyWindow?.addConstraints(constraints)
  }
}