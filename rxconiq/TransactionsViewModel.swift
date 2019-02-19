//
//  TransactionsViewModel.swift
//  rxconiq
//
//  Created by Boska on 2019/1/19.
//  Copyright © 2019 boska. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base == TransactionsViewModel {
  var items: Driver<[Transaction]> { return base.items }
  var loadNextPage: BehaviorRelay<Bool> { return base.loadNextPage }
}

struct TransactionsViewModel: ReactiveCompatible {
  fileprivate let items: Driver<[Transaction]>
  fileprivate let loadNextPage = BehaviorRelay(value: true)

  init(provider: Observable<[Transaction]>) {
    items = Observable.zip(loadNextPage, provider)
      .map { $1 }
      .asDriver(onErrorJustReturn: [])
      .scan([]) { $0 + $1 }
  }
}
