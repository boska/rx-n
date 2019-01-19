//
//  TransactionsViewModel.swift
//  rxconiq
//
//  Created by Boska on 2019/1/19.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import RxCocoa

class TransactionsTableViewModel {
  let disposeBag = DisposeBag()
  let decoder = JSONDecoder()
  let items: BehaviorRelay<[Transaction]> = BehaviorRelay(value: [])
  let sourceURL = BehaviorRelay(value: "http://demo5481020.mockable.io/transactions")
  let loadNextPage = BehaviorSubject(value: true)
  init() {
    Observable.zip(sourceURL, loadNextPage) // change zip to combineLatest to see infinite scroll
      .debug("⏳")
      .flatMap { requestData(.get, $0.0) }
      .do(onNext: { [unowned self] in
        guard let nextPage = $0.0.allHeaderFields["next-page"] as? String else {
          return
        }
        if (!nextPage.isEmpty) {
          self.sourceURL.accept(nextPage)
        }
      })
      .map { try self.decoder.decode([Transaction].self, from: $0.1) }
      .catchErrorJustReturn([])
      .scan([]) { $0 + $1 }
      .bind(to: items)
      .disposed(by: disposeBag)
  }
}
