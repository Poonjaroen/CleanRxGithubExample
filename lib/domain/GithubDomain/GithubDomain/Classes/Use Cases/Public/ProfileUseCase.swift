//
// Created by Arnon Keereena on 11/1/2019 AD.
//

import Foundation
import RxSwift

public protocol ProfileUseCase {
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
