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
  .flatMap({ endPoint in
    requestData(.get, endPoint)
      .do(onNext: { (response, _) in
        guard let nextPage = response.allHeaderFields["next-page"] as? String else {
          return
        }
        if (!nextPage.isEmpty) {
          transactionsApiEndpoint.accept(nextPage)
        }
      })
      .map({ (_, data) in
        try decoder.decode([Transaction].self, from: data)
      })
  })
