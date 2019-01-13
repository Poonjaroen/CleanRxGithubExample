//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation

public struct SearchRepoRequest {
  public var query: String? = nil
  public var sort: String? = nil
  public var order: String = "desc"
  
  public init() {}
  
  public init(query: String) {
    self.query = query
  }
}