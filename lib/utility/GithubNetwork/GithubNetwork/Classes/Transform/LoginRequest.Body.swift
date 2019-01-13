//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation
import GithubDomain

extension LoginRequest {
  var body: Body {
    return Body.init(scopes: scopes, note: note)
  }
  
  struct Body: Encodable {
    var scopes: [String]
    var note: String?
    
    init(scopes: [String] = ["public_repo"], note: String? = nil) {
      self.scopes = scopes
      self.note = note
    }
  }
}