//
//  TransactionsViewModel.swift
//  rxconiq
//
//  Created by Boska on 2019/1/19.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct TransactionsViewModel {
  let items: BehaviorRelay<[Transaction]> = BehaviorRelay(value: [])
  let loadNextPage = BehaviorRelay(value: true)
  private let disposeBag = DisposeBag()
  init(provider: Observable<[Transaction]>) {
    _ = Observable.zip(loadNextPage, provider)
      .map { $1 }
      .debug("load")
      .asDriver(onErrorJustReturn: [])
      .scan([]) { $0 + $1 } /* item manipulate */
      .drive(items)
      .disposed(by: disposeBag)
  }
}
