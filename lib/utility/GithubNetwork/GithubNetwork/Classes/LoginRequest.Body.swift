//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation

extension LoginRequest {
  struct Body: Encodable {
    var scopes: [String]
    var note: String?
    
    init(scopes: [String] = ["public_repo"], note: String? = nil) {
      self.scopes = scopes
      self.note = note
    }
  }
}