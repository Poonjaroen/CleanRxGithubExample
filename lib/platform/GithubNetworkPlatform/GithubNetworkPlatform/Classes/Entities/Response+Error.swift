//
// Created by Arnon Keereena on 23/12/2018 AD.
//

import Foundation
import GithubDomain
import Moya

extension Response {
  var error: Error? {
    if statusCode > 299 && statusCode < 500 {
      return APIError(code: statusCode, body: data)
    } else if statusCode > 499 {
      return NetworkError()
    } else {
      return nil
    }
  }
  
  func jsonString() throws -> String? {
    if let error = error {
      throw error
    } else {
      return String(data: data, encoding: .utf8)
    }
  }
}