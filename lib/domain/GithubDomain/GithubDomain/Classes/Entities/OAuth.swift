//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation

public struct OAuth {
  public var accessToken: String
  public var refreshToken: String
  
  public init(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}