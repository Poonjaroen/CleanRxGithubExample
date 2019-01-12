//
// Created by Arnon Keereena on 12/1/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation

extension Optional {
  func selectWith<T, R>(_ anotherOptional: Optional<T>, selector: (Wrapped, T) -> R?) -> R? {
    return self.flatMap { left in
      anotherOptional.flatMap { right in selector(left, right) }
    }
  }
}
