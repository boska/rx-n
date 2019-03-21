//
//  Transaction.swift
//  rxconiq
//
//  Created by Boska on 2019/1/19.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation
import MapKit

struct Transaction: Codable {
  var coordinates: String
  var date: String
  var effectiveDate: String
  var description: String
  var amount: String
  enum CodingKeys: String, CodingKey {
    case effectiveDate = "effective date"
    case coordinates
    case date
    case description
    case amount
  }
}

extension Transaction {
  var mapItem: MKMapItem? {
    let coordinatesDoubles = coordinates
      .split(separator: ",")
      .map({ $0.trimmingCharacters(in: .whitespaces) })
      .compactMap({ Double($0) })
    
    guard
      let latitude = coordinatesDoubles.first,
      let longitude = coordinatesDoubles.last
    else {
      return nil
    }
    
    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
    mapItem.name = "\(description) @ \(effectiveDate) (€ \(amount))"
    return mapItem
  }
  
  func alert() -> UIAlertController {
    let alert = UIAlertController(title: "\(description) € \(amount) \n \(effectiveDate)", message: coordinates, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Open In Maps", style: .default, handler: { _ in
      if let mapItem = self.mapItem {
        mapItem.openInMaps()
      }
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    return alert
  }
}
