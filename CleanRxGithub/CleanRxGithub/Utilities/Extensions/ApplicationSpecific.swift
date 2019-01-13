//
// Created by Arnon Keereena on 12/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension UITabBar {
  func toAppStyle() {
    shadowImage = .with(color: .clear)
    backgroundImage = .with(color: .init(red: 0.04, green: 0.30, blue: 0.55, alpha: 0.9))
  }
}

extension UINavigationBar {
  func toAppStyle() {
    shadowImage = .with(color: .clear)
    setBackgroundImage(.with(color: .init(red: 0.1, green: 0.1, blue: 1, alpha: 0.3)), for: .default)
    addBlur()
  }
}

extension UIView {
  func addBlur() {
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = bounds
    blurEffectView.alpha = 0.8
    addSubview(blurEffectView)
    sendSubviewToBack(blurEffectView)
  }
}