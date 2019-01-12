//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import GithubDomain

extension Response {
  func toModel<T: BaseMappable>(_ type: T.Type) -> T? {
    do {
      guard let string = try jsonString() else { return nil }
      return type.init(JSONString: string)
    } catch {
      return nil
    }
  }
  
  func toModels<T: BaseMappable>(_ type: T.Type) -> [T]? {
    do {
      guard let string = try jsonString() else { return nil }
      return Mapper<T>().mapArray(JSONString: string)
    } catch {
      return nil
    }
  }
}