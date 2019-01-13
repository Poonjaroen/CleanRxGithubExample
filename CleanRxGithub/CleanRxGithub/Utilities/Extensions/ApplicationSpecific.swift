//
// Created by Arnon Keereena on 12/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension UITabBar {
  func toAppStyle() {
    shadowImage = .with(color: .clear)
    backgroundImage = .with(color: .init(red: 0, green: 0, blue: 0, alpha: 0.5))
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = frame
    blurEffectView.alpha = 0.5
    addSubview(blurEffectView)
  }
}

extension UINavigationBar {
  func toAppStyle() {
    setBackgroundImage(.with(color: .init(red: 0, green: 0, blue: 0, alpha: 0.5)), for: .default)
    shadowImage = .with(color: .clear)
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = frame
    blurEffectView.alpha = 0.5
    addSubview(blurEffectView)
  }
}