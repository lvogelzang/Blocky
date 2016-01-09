//
//  AppDelegate.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 16-07-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        return true
    
    }
    
    // Pause game when app becomes inactive by pressing home button or temporary interruptions.
    func applicationWillResignActive(application: UIApplication) {

        if let mainViewController = window?.rootViewController as? MainViewController {
            mainViewController.setMenuHidden(true)
        }
        
    }

}
