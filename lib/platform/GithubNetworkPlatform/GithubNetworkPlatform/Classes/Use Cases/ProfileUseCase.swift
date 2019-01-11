//
// Created by Arnon Keereena on 11/1/2019 AD.
//

import Foundation
import GithubDomain
import GithubNetwork
import RxSwift

public class ProfileUseCase: GithubDomain.ProfileUseCase {
  
  let session: UserSession
  var network: Provider
  
  public convenience init(session: UserSession, network: Provider) {
    self.init(session: session)
    self.network = network
  }
  
  public required init(session: UserSession) {
    self.session = session
    self.network = Provider()
  }
  
  public func myProfile() -> Single<UserProfile?> {
    return userProfile(username: session.username)
  }
  
  public func userProfile(username: String) -> Single<UserProfile?> {
    return network.rx.request(.profile(username: username))
                     .map { $0.toModel(UserProfile.self) }
  }
}
