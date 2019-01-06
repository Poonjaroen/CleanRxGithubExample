//
// Created by Arnon Keereena on 6/1/2019 AD.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import GithubDomain

extension Single where Element: Response {
  func mapToModel<T: BaseMappable>(_ type: T.Type) -> Single<T> {
    return map {
      guard let model = T.init(JSONString: try $0.jsonString()) else { throw NetworkError() }
      return model
    }
  }
  
  func mapToModels<T: BaseMappable>(_ type: T.Type) -> Single<[T]> {
    return map { Mapper<T>().mapArray(JSONString: try $0.jsonString()) }
  }
}