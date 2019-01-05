//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation

public struct APIError: Error {
  public var code: Int
  public var body: Data?
  public var message: String {
    return body.flatMap { String(data: $0, encoding: .utf8) } ?? ""
  }
  
  public init(code: Int, body: Data?) {
    self.code = code
    self.body = body
  }
}

