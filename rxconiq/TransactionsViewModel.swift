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

  init(provider: Observable<[Transaction]>) {
    items = provider
      .asDriver(onErrorJustReturn: [])
  }
}
