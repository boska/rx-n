//
//  TinyRouter.swift
//  rxconiq
//
//  Created by Boska on 2019/1/22.
//  Copyright © 2019 boska. All rights reserved.
//

import Foundation
import UIKit

class TinyRouter {
  var root: UIViewController?
  static let shared = TinyRouter()
  func navigate(to: Transaction) {
    self.root?.present(to.alert(), animated: true)
  }
}
