//
//  AppDelegate.swift
//  rxconiq
//
//  Created by Boska on 2019/1/17.
//  Copyright © 2019 boska. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    let tab = UITabBarController(nibName: nil, bundle: nil)
    tab.viewControllers = [TransactionsViewController(viewModel: TransactionsViewModel(provider: transactionsProvider)), UserViewController(viewModel: UserViewModel())]
    TinyRouter.shared.root = tab
    window?.rootViewController = tab
    return true
  }
}

