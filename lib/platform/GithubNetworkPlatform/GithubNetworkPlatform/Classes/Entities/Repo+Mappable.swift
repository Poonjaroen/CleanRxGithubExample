//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation
import GithubDomain
import ObjectMapper

extension Repo: ImmutableMappable {
  public init(map: Map) {
    self.init()
    self.mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
     id <- map["id"]
     nodeId <- map["node_id"]
     name <- map["name"]
     fullName <- map["full_name"]
     owner <- map["owner"]
     isPrivate <- map["private"]
     htmlUrl <- map["html_url"]
     description <- map["description"]
     isFork <- map["fork"]
     url <- map["url"]
     createdAt <- map["created_at"]
     updatedAt <- map["updated_at"]
     pushedAt <- map["pushed_at"]
     homepage <- map["homepage"]
     size <- map["size"]
     stargazersCount <- map["stargazers_count"]
     watchersCount <- map["watchers_count"]
     language <- map["language"]
     forksCount <- map["forks_count"]
     openIssuesCount <- map["open_issues_count"]
     masterBranch <- map["master_branch"]
     defaultBranch <- map["default_branch"]
     score <- map["score"]
  }
}