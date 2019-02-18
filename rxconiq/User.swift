//
//  User.swift
//  rxconiq
//
//  Created by Boska on 2019/1/19.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import RxCocoa

struct User: Codable {
  var name: String = "Loading..."
  var surname: String = ""
  var birthdate: String = ""
  var nationality: String = ""

  enum CodingKeys: String, CodingKey {
    case name
    case surname
    case birthdate = "Birthdate"
    case nationality = "Nationality"
  }
}

struct UserViewModel {
  let user = BehaviorRelay.init(value: User())
  private let decoder = JSONDecoder()
  private let disposeBag = DisposeBag()

  init() {
    _ = requestData(.get, "http://demo5481020.mockable.io/userinfo")
      .map { [decoder] in try decoder.decode(User.self, from: $0.1) }
      .asDriver(onErrorJustReturn: User())
      .drive(user)
      .disposed(by: disposeBag)
  }
}
