//
// Created by Arnon Keereena on 12/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  func toImage(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    return UIGraphicsImageRenderer(size: size).image { rendererContext in
      self.setFill()
      rendererContext.fill(CGRect(origin: .zero, size: size))
    }
  }
}

extension UIImage {
  static func with(color: UIColor) -> UIImage {
    return color.toImage()
  }
}