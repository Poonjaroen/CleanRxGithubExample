//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation
import GithubDomain
import ObjectMapper

extension SearchRepoResponse: ImmutableMappable {
  public init(map: Map) {
    self.init()
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    totalCount <- map["total_count"]
    isIncompleteResults <- map["incomplete_results"]
    items <- map["items"]
  }
}