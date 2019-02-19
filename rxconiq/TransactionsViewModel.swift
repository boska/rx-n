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
}

struct TransactionsViewModel: ReactiveCompatible {
  fileprivate let items: Driver<[Transaction]>
  let loadNextPage = BehaviorRelay(value: true)
  private let disposeBag = DisposeBag()
  init(provider: Observable<[Transaction]>) {
    items = Observable.zip(loadNextPage, provider)
      .map { $1 }
      .asDriver(onErrorJustReturn: [])
      .scan([]) { $0 + $1 }
  }
}
