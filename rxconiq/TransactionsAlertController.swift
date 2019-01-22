//
//  TransactionsAlertController.swift
//  rxconiq
//
//  Created by Boska on 2019/1/22.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation

import MapKit

func transactionAlertController(transaction: Transaction) -> UIAlertController {
  let view = UIAlertController(title: "\(transaction.description) € \(transaction.amount) \n \(transaction.effectiveDate)", message: transaction.coordinates, preferredStyle: .actionSheet)
  view.addAction(UIAlertAction(title: "Open In Maps", style: .default, handler: {

    _ in
    let coordinates = transaction.coordinates
      .split(separator: ",")
      .map { Double($0.replacingOccurrences(of: " ", with: "")) ?? 0.0 }
    let coordinate = CLLocationCoordinate2DMake(coordinates[0], coordinates[1])
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))

    mapItem.name = "\(transaction.description) @ \(transaction.effectiveDate) (€ \(transaction.amount))"
    mapItem.openInMaps()

  }))
  view.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
  return view
}
