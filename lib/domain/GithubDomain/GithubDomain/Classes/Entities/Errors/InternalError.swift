//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation

public struct InternalError: LocalizedError {
  public var errorDescription: String? {
    return "Unknown internal error ocurred"
  }
  
  public init() {}
}