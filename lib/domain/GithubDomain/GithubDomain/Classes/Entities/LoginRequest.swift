//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation

public struct LoginRequest {
  public var username: String
  public var password: String
  public var scopes: [String]
  public var note: String?
  
  public init(username: String,
              password: String,
              scopes: [String] = ["public_repo"],
              note: String? = nil) {
    self.username = username
    self.password = password
    self.scopes = scopes
    self.note = note
  }
}