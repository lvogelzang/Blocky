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
        
        // TODO: let databaseName = "TriesDatabase.sql"
        
        Database.createDatabaseIfNotExist()
        
        // TODO. Wrong
        Database.increaseTriesForScene(1)
        
        return true
    }
    
    /*- (void) updateStep5ForForm:(SKForm *)skform {
    sqlite3 *database;
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
    const char *sqlStatement = (const char*)[[NSString stringWithFormat:@"UPDATE step5 SET skid = '%d', measurement = '%@', url1 = '%@', maintainingaction = '%@', url2 = '%@' WHERE skid = %d;", skform.skformid, skform.step5.measurement, skform.step5.result, skform.step5.maintainingAction, skform.step5.jobcard, skform.skformid] UTF8String];
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
    sqlite3_step(compiledStatement);
    }
    sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
    }*/
    
    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

