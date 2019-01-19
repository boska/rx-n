//
//  Transaction.swift
//  rxconiq
//
//  Created by Boska on 2019/1/19.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation

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
