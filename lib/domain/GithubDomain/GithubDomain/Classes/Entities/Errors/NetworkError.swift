//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation

public struct NetworkError: LocalizedError {
  public var errorDescription: String? {
    return "Network failed"
  }
  
  public init() {}
}