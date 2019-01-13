//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation
import GithubDomain
import ObjectMapper

extension RepoOwner: ImmutableMappable {
  public init(map: Map) {
    self.init()
    self.mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    login <- map["login"]
    id <- map["id"]
    nodeId <- map["node_id"]
    avatarUrl <- map["avatar_url"]
    gravatarId <- map["gravatar_id"]
    url <- map["url"]
    receivedEventsUrl <- map["received_events_url"]
    type <- map["type"]
  }
}