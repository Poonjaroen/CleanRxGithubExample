//
// Created by Arnon Keereena on 11/1/2019 AD.
//

import Foundation
import RxSwift

public protocol ProfileUseCase {
  // The use case requires user session to knows how to get my profile
  init(session: UserSession)
  
  /// Get currently logged-in user profile
  ///
  /// - Returns: Single user profile of the current session
  func myProfile() -> Single<UserProfile>
  
  /// Get profile of the specified user
  ///
  /// - Parameter username: Username whose profile will be fetched
  /// - Returns: Single user profile of the specified user
  func userProfile(username: String) -> Single<UserProfile>
}
