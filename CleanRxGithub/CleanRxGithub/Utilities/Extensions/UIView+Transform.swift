//
// Created by Arnon Keereena on 12/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func beCircle() {
    let radius = frame.size.width / 2
    layer.cornerRadius = radius
    layer.masksToBounds = true
  }
  
  func addShadow(pathLike view: UIView,
                 color: UIColor = .black,
                 offset: CGSize = .init(width: 0, height: 8),
                 opacity: Float = 0.2,
                 radius: CGFloat = 4) {
    layer.frame = view.bounds
    layer.cornerRadius = view.layer.cornerRadius
    layer.shadowColor = color.cgColor
    layer.masksToBounds = false
    layer.shadowOffset = offset
    layer.shadowOpacity = opacity
    layer.shadowRadius = radius
  }
}
