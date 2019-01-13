//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation
import GithubDomain

extension SearchRepoRequest {
  public var parameters: [String: Any] {
    let keyValues: [(String, Any?)] = [
      ("q", query),
      ("sort", sort),
      ("order", order)
    ].filter { $0.1 != nil }
    return keyValues.reduce(into: [String: Any]()) { $0[$1.0] = $1.1 }
  }
}