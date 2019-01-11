//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import Moya

public enum Target: Moya.TargetType {
  case login(request: LoginRequest)
  case profile(username: String)
  
  public var baseURL: URL {
    return URL(string: "https://api.github.com")!
  }
  
  public var path: String {
    switch self {
    case .login: return "/authorizations"
    case .profile(let username): return "/users/\(username)"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .login: return .post
    case .profile: return .get
    }
  }
  
  public var sampleData: Data {
    return Data()
  }
  
  public var task: Task {
    switch self {
    case .login(let request): return Task.requestJSONEncodable(request.body)
    case .profile: return Task.requestPlain
    }
  }
  
  public var headers: [String: String]? {
    switch self {
    case .login(let request):
      let credentials = "\(request.username):\(request.password)"
      let base64 = credentials.data(using: .utf8)?.base64EncodedString() ?? ""
      return ["Authorization": "Basic \(base64)"]
    case .profile: return [:]
    }
  }
}
