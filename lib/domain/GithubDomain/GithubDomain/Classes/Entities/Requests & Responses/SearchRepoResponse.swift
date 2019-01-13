//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation

public struct SearchRepoRepsonse {
  public var totalCount: Int = -1
  public var isIncompleteResults = false
  public var items: [Repo]
}