//
// Created by Arnon Keereena on 12/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func animateMagicMove(to view: UIView,
                        duration: TimeInterval = 0.4,
                        addOnAnimationsDelay: TimeInterval = 0,
                        addOnAnimations: @escaping (UIView) -> Void = { _ in }) {
    animateMagicMove(to: view,
                     duration: duration,
                     addOnAnimationsDelay: addOnAnimationsDelay,
                     addOnAnimations: addOnAnimations,
                     completion: nil)
  }
  
  func animateMagicMove(to view: UIView,
                        duration: TimeInterval = 0.4,
                        addOnAnimationsDelay: TimeInterval = 0,
                        addOnAnimations: @escaping (UIView) -> Void = { _ in },
                        completion: (() -> Void)? = nil) {
    if addOnAnimationsDelay > 0 {
      UIView.animate(
        withDuration: duration,
        delay: addOnAnimationsDelay,
        options: .curveEaseInOut,
        animations: { [weak self] in self.flatMap { addOnAnimations($0) } },
        completion: nil
      )
    }
    
    UIView.animate(
      withDuration: duration,
      delay: 0,
      options: .curveEaseInOut,
      animations: { [weak self] in
        guard let _self = self else { return }
        _self.layer.cornerRadius = view.layer.cornerRadius
        _self.removeConstraints(_self.constraints)
        _self.addConstraintsToLocation(of: view)
        (_self.superview ?? _self).layoutIfNeeded()
        guard addOnAnimationsDelay <= 0 else { return }
        addOnAnimations(_self)
      },
      completion: { bool in completion?() }
    )
  }
}
