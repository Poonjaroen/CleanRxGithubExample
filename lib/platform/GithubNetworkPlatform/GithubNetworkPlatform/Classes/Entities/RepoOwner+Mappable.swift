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
    nodeId <- map["nodeId"]
    avatarUrl <- map["avatarUrl"]
    gravatarId <- map["gravatarId"]
    url <- map["url"]
    receivedEventsUrl <- map["receivedEventsUrl"]
    type <- map["type"]
  }
}