//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation
import GithubDomain

extension UserSession {
  init(loginResponse: LoginResponse, username: String) throws {
    let refreshToken = ""
    if let accessToken = loginResponse.token {
      self.init(username: username, accessToken: accessToken, refreshToken: refreshToken)
    } else {
      throw InternalError()
    }
  }
}

