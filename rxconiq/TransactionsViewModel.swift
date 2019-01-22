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

final class TransactionsViewModel {
  let items: BehaviorRelay<[Transaction]> = BehaviorRelay(value: [])
  let loadNextPage = BehaviorSubject(value: true)
  private let disposeBag = DisposeBag()
  private let decoder = JSONDecoder()
  private let sourceURL = BehaviorRelay(value: "http://demo5481020.mockable.io/transactions")
  init() {
    _ = Observable.zip(sourceURL, loadNextPage) // change zip to combineLatest to see infinite scroll
    .debug("🌍")
      .flatMapLatest { requestData(.get, $0.0) }
      .do(onNext: { [unowned self] in
        guard let nextPage = $0.0.allHeaderFields["next-page"] as? String else {
          return
        }
        if (!nextPage.isEmpty) {
          self.sourceURL.accept(nextPage) // it will wait until next event in loadNextPage
        }
      })
      .map { try self.decoder.decode([Transaction].self, from: $0.1) }
      .asDriver(onErrorJustReturn: [])
      .scan([]) { $0 + $1 } // items manipulate
    .drive(items)
  }
}
