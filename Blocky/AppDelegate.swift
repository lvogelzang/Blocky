//
//  AppDelegate.swift
//  Blocky
//
//  Created by Lodewijck on 11/08/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if let mainViewController = window?.rootViewController as? MainViewController {
            mainViewController.setMenuVisible(true)
        }
    }

}
