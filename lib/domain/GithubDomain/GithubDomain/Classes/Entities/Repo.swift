//
// Created by Arnon Keereena on 13/1/2019 AD.
//

import Foundation

public struct Repo {
  public var id: Int = -1
  public var nodeId: String?
  public var name: String?
  public var fullName: String?
  public var owner: RepoOwner?
  public var isPrivate: Bool = false
  public var htmlUrl: String?
  public var description: String?
  public var isFork: Bool = false
  public var url: String?
  public var createdAt: Date?
  public var updatedAt: Date?
  public var pushedAt: Date?
  public var homepage: String?
  public var size: Int = -1
  public var stargazersCount: Int = -1
  public var watchersCount: Int = -1
  public var language: String?
  public var forksCount: Int = -1
  public var openIssuesCount: Int = -1
  public var masterBranch: String?
  public var defaultBranch: String?
  public var score: String?
}