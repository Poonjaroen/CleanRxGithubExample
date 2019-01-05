//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import Moya

public enum Target: Moya.TargetType {
  case login(username: String, password: String)
  
  public var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }
  
  public var path: String {
    switch self {
    case .login(let username, _): return "/users/\(username)"
    }
  }
  
  public var method: Moya.Method {
    return .get
  }
  
  public var sampleData: Data {
    return Data()
  }
  
  public var task: Task {
    return Task.requestPlain
  }
  
  public var headers: [String: String]? {
    switch self {
    case .login(let username, let password):
      let credentials = "\(username):\(password)"
      let base64 = credentials.data(using: .utf8)?.base64EncodedString() ?? ""
      return ["Authorization": "Basic \(base64)"]
    }
  }
}
