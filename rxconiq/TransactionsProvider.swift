//
//  TransactionsProvider.swift
//  rxconiq
//
//  Created by Boska on 2019/2/4.
//  Copyright © 2019 boska. All rights reserved.
//

import RxAlamofire
import RxCocoa

private let decoder = JSONDecoder()

private let transactionsApiEndpoint = BehaviorRelay(value: "http://demo5481020.mockable.io/transactions")

let transactionsProvider = transactionsApiEndpoint
  .flatMap {
    requestData(.get, $0)
      .do(onNext: {
        guard let nextPage = $0.0.allHeaderFields["next-page"] as? String else {
          return
        }
        if (!nextPage.isEmpty) {
          transactionsApiEndpoint.accept(nextPage) // it will wait until next event in loadNextPage
        }
      })
      .map {
        try decoder.decode([Transaction].self, from: $0.1)
    }

}
