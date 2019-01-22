//
//  User.swift
//  rxconiq
//
//  Created by Boska on 2019/1/19.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation

struct User: Codable {
  var name: String = "Loading..."
  var surname: String = ""
  var birthdate: String = ""
  var nationality: String = ""
  
  enum CodingKeys: String, CodingKey {
    case name
    case surname
    case birthdate = "Birthdate"
    case nationality = "Nationality"
  }
}
