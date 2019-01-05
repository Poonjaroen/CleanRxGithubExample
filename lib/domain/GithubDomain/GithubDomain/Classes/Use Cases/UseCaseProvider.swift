//
// Created by Arnon Keereena on 22/12/2018 AD.
//

import Foundation

public protocol UseCaseProvider {
  func makeLoginUseCase() -> AuthenticationUseCase
}
