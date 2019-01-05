//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation

struct NetworkError: LocalizedError {
  public var errorDescription: String? {
    self.localizedDescription
    return "Network failed"
  }
}