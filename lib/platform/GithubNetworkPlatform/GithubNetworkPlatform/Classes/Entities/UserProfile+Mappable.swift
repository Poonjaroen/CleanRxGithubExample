//
// Created by Arnon Keereena on 11/1/2019 AD.
//

import Foundation
import GithubDomain
import ObjectMapper

extension UserProfile: ImmutableMappable {
  
  public init(map: Map) {
    self.init()
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    login <- map["login"]
    id <- map["id"]
    nodeId <- map["node_id"]
    avatarUrl <- map["avatar_url"]
    gravatarId <- map["gravatar_id"]
    url <- map["url"]
    htmlUrl <- map["html_url"]
    followersUrl <- map["followers_url"]
    followingUrl <- map["following_url"]
    gistsUrl <- map["gists_url"]
    starredUrl <- map["starred_url"]
    subscriptionsUrl <- map["subscriptions_url"]
    organizationsUrl <- map["organizations_url"]
    reposUrl <- map["repos_url"]
    eventsUrl <- map["events_url"]
    receivedEventsUrl <- map["received_events_url"]
    type <- map["type"]
    siteAdmin <- map["site_admin"]
    name <- map["name"]
    company <- map["company"]
    blog <- map["blog"]
    location <- map["location"]
    email <- map["email"]
    hireable <- map["hireable"]
    bio <- map["bio"]
    publicRepos <- map["public_repos"]
    publicGists <- map["public_gists"]
    followers <- map["followers"]
    following <- map["following"]
    createdAt <- map["created_at"]
    updatedAt <- map["updated_at"]
  }
  
}
