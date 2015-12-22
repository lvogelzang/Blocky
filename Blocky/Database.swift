//
//  Database.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-08-15.
//  Copyright (c) 2015 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

let databaseName = "TriesDatabase.sql"

class Database: NSObject {
    
    class func getDatabasePath() -> String {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        return documentsPath.stringByAppendingPathComponent(databaseName)
        
    }
    
    class func createDatabaseIfNotExist() {
        
        let databasePath = Database.getDatabasePath()
        
        let fileManager = NSFileManager()
        let databaseExists = fileManager.fileExistsAtPath(databasePath)
        
        if (!databaseExists) {
            
            let databasePathFromApp = (NSBundle.mainBundle().resourcePath! as NSString).stringByAppendingPathComponent(databaseName)
            
            do {
                try fileManager.copyItemAtPath(databasePathFromApp, toPath: databasePath)
            } catch _ {
            }
            
        }
        
    }
    
    class func increaseTriesForScene(number: Int) {
        
        let databasePath = Database.getDatabasePath()
        
        // open database
        var db: COpaquePointer = nil
        if sqlite3_open(databasePath, &db) != SQLITE_OK {
            print("Error opening database.")
        }
        
        if sqlite3_exec(db, "create table if not exists test (id integer primary key autoincrement, name text)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String.fromCString(sqlite3_errmsg(db))
            print("error creating table: \(errmsg)")
        }
        
    }
   
}
