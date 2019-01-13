//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation
import GithubDomain
import GithubNetwork
import ObjectMapper

extension LoginResponse: ImmutableMappable {
  
  public init(map: Map) throws {
    self.init()
    self.mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    id <- map["id"]
    url <- map["url"]
    id = url.flatMap { $0.split(separator: "/").last }.flatMap { String($0) }
    scopes <- map["scopes"]
    token <- map["token"]
    tokenLastEight <- map["token_last_eight"]
    hashedToken <- map["hashed_token"]
    note <- map["note"]
    noteUrl <- map["note_url"]
    updatedAt <- map["updated_at"]
    createdAt <- map["created_at"]
    fingerprint <- map["fingerprint"]
  }
}
