//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation

public struct UserSession {
  public var username: String
  public var oauth: OAuth
 
  public init(username: String, accessToken: String, refreshToken: String) {
    self.username = username
    self.oauth = OAuth(accessToken: accessToken, refreshToken: refreshToken)
  }
}