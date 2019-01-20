//
//  TransactionViewController.swift
//  rxconiq
//
//  Created by Boska on 2019/1/19.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import RxSwift
import RxCocoa

class TransactionViewController: UIViewController {
  var model: Transaction? 
  let encoder = JSONEncoder()
  let disposeBag = DisposeBag()
  @IBOutlet weak var openInAppleMap: UIButton!
  @IBOutlet weak var detailLabel: UILabel!
  override func viewDidLoad() {
    encoder.outputFormatting = .prettyPrinted
    guard let transaction = self.model
      else {
        return
    }
    
    _ = Observable.just(transaction)
      .map { try self.encoder.encode($0) }
      .map { String(data: $0, encoding: .utf8) }
      .bind(to: detailLabel.rx.text)
      .disposed(by: disposeBag)

    openInAppleMap.rx.tap.subscribe { _ in
      let coordinates = transaction.coordinates
        .split(separator: ",")
        .map { Double($0.replacingOccurrences(of: " ", with: "")) ?? 0.0 }
      let coordinate = CLLocationCoordinate2DMake(coordinates[0], coordinates[1])
      let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))

      mapItem.name = "\(transaction.description) @ \(transaction.effectiveDate) (€ \(transaction.amount))"
      mapItem.openInMaps()
    }.disposed(by: disposeBag)

  }
}

extension ObservableType {

  /**
   Takes a sequence of optional elements and returns a sequence of non-optional elements, filtering out any nil values.
   - returns: An observable sequence of non-optional elements
   */

  public func unwrap<T>() -> Observable<T> where E == T? {
    return self.filter { $0 != nil }.map { $0! }
  }
}
