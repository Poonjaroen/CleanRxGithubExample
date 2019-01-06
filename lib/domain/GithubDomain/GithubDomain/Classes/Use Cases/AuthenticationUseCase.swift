//
// Created by Arnon Keereena on 22/12/2018 AD.
//

import Foundation
import RxSwift

public protocol AuthenticationUseCase {
  func login(username: String,
             password: String,
             scopes: [String],
             note: String?) -> Single<UserSession>
  
  func logout() -> Single<Void>
  
  func recoverUserSession() -> Single<UserSession?>
}