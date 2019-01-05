//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation

public struct LoginResponse {
  public var id: String?
  public var url: String?
  public var scopes: [String]
  public var token: String?
  public var tokenLastEight: String?
  public var hashedToken: String?
  public var note: String?
  public var noteUrl: String?
  public var updatedAt: Date?
  public var createdAt: Date?
  public var fingerprint: String?
}