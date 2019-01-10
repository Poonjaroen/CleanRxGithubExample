//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation
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
