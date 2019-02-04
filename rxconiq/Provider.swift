//
//  Provider.swift
//  rxconiq
//
//  Created by Boska on 2019/2/4.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import RxCocoa

let decoder = JSONDecoder()

let transactionApi = BehaviorRelay(value: "http://demo5481020.mockable.io/transactions")

let transactionsProvider = transactionApi
  .flatMap { requestData(.get, $0)
    .do(onNext: {
      guard let nextPage = $0.0.allHeaderFields["next-page"] as? String else {
        return
      }
      if (!nextPage.isEmpty) {
        transactionApi.accept(nextPage) // it will wait until next event in loadNextPage
      }
    })
    .map {
      try decoder.decode([Transaction].self, from: $0.1)
    }}
