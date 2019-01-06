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
  
  public init() {
    id = nil
    url = nil
    scopes = []
    token = nil
    tokenLastEight = nil
    hashedToken = nil
    note = nil
    noteUrl = nil
    updatedAt = nil
    createdAt = nil
    fingerprint = nil
  }
}