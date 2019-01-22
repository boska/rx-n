//
//  AppDelegate.swift
//  rxconiq
//
//  Created by Boska on 2019/1/17.
//  Copyright © 2019 boska. All rights reserved.
//
/*
 db   db d88888b db      db       .d88b.
 88   88 88'     88      88      .8P  Y8.
 88ooo88 88ooooo 88      88      88    88
 88~~~88 88~~~~~ 88      88      88    88
 88   88 88.     88booo. 88booo. `8b  d8'
 YP   YP Y88888P Y88888P Y88888P  `Y88P'
 
 d8888b.  .d8b.  db    db  .o88b.  .d88b.  d8b   db d888888b  .d88b.
 88  `8D d8' `8b `8b  d8' d8P  Y8 .8P  Y8. 888o  88   `88'   .8P  Y8.
 88oodD' 88ooo88  `8bd8'  8P      88    88 88V8o 88    88    88    88
 88~~~   88~~~88    88    8b      88    88 88 V8o88    88    88    88
 88      88   88    88    Y8b  d8 `8b  d8' 88  V888   .88.   `8P  d8'
 88      YP   YP    YP     `Y88P'  `Y88P'  VP   V8P Y888888P  `Y88'Y8
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    let tab = UITabBarController(nibName: nil, bundle: nil)
    tab.viewControllers = [TransactionsViewController(viewModel: TransactionsViewModel()), UserViewController(viewModel: UserViewModel())]
    TinyRouter.shared.root = tab
    window?.rootViewController = tab
    return true
  }
}

