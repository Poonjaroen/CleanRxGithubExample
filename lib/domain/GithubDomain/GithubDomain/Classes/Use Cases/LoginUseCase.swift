//
// Created by Arnon Keereena on 22/12/2018 AD.
//

import Foundation
import RxSwift

public protocol LoginUseCase {
  func login(username: String, password: String) -> Single<Void>
  
  func logout() -> Single<Void>
  
  func recoverUserSession() -> Single<UserSession>
}