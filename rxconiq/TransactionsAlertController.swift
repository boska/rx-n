//
//  TransactionsAlertController.swift
//  rxconiq
//
//  Created by Boska on 2019/1/22.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation
import UIKit

func transactionAlertController(transaction: Transaction) -> UIAlertController {
  let alert = UIAlertController(title: "\(transaction.description) € \(transaction.amount) \n \(transaction.effectiveDate)", message: transaction.coordinates, preferredStyle: .actionSheet)
  alert.addAction(UIAlertAction(title: "Open In Maps", style: .default, handler: { _ in
    if let mapItem = transaction.mapItem {
      mapItem.openInMaps()
    }
  }))
  alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
  return alert
}
