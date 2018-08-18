//
//  Database.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-08-15.
//  Copyright (c) 2015 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SQLite3

let databaseName = "TriesDatabase.sql"

class Database: NSObject {
    
    // MARK: - Public functions
    
    // Creates a SQL database with an empty table called tries if not exist yet. Built like:
    // Create table tries(level smallint primary key, tries smallint, best smallint);
    // Runs database updates that are added after first release of Blocky.
    class func initializeDatabase() {
        let databasePath = Database.getDatabasePath()
        let fileManager = FileManager()
        let databaseExists = fileManager.fileExists(atPath: databasePath)
        
        if (!databaseExists) {
            let databasePathFromBundle = (Bundle.main.resourcePath! as NSString).appendingPathComponent(databaseName)
            do {
                try fileManager.copyItem(atPath: databasePathFromBundle, toPath: databasePath)
            } catch _ {
                print("Failed to copy database from bundle to app.")
            }
        }
        
        let updates = ["create table tutorial (executed bool)"]
        
        for i in 0 ..< updates.count {
            if executeSQLStatement("select 1 from build_updates where bu_id = \(i)") == -1 {
                executeSQLStatement(updates[i])
                executeSQLStatement("insert into build_updates (bu_id) values (\(i))")
            }
        }
    }
    
    class func hasCompletedTutorial() -> Bool {
        return executeSQLStatement("select count(*) from tutorial") > 0
    }
    
    class func setCompletedTutorial() {
        executeSQLStatement("insert into tutorial (executed) values (1)")
    }
    
    // Called after player won a level. Resets number of tries, and recalculates best score.
    class func wonLevel(_ level: Int) {
        setCompletedTutorial()
        let triesForLevel = Database.getTriesForLevel(level)
        var bestForLevel = Database.getBestForLevel(level)
        
        if (triesForLevel < bestForLevel) {
            bestForLevel = triesForLevel
        }
        
        let wonStatement = "update tries set tries = 0, best = \(bestForLevel) where level = \(level);"
        Database.executeSQLStatement(level, statement: wonStatement)
    }
    
    // Increment tries for specified level.
    class func incrementTriesForLevel(_ level: Int) {
        let triesForLevel = Database.getTriesForLevel(level)
        let increaseTriesStatement = "update tries set tries = \(triesForLevel+1) where level = \(level);"
        Database.executeSQLStatement(level, statement: increaseTriesStatement)
    }
    
    // Gets the amount of tries in the current streak for a level.
    class func getTriesForLevel(_ level: Int) -> Int {
        let getTriesStatement = "select tries from tries where level = \(level)"
        return Database.executeSQLStatement(level, statement: getTriesStatement)
    }
    
    // Gets the minimum amount of tries needed for a level.
    class func getBestForLevel(_ level: Int) -> Int {
        let getBestStatement = "select best from tries where level = \(level)"
        return Database.executeSQLStatement(level, statement: getBestStatement)
    }
    
    // MARK: - Private functions
    
    // First private method called when using the database.
    // Executes a SQL statement without verifying.
    // Creates database if database does not exist yet.
    // Creates level if level is not known in database yet.
    // Returns first result of query if result is not empty.
    @discardableResult
    fileprivate class func executeSQLStatement(_ level: Int, statement: String) -> Int {
        Database.createLevelIfNotExist(level)
        return Database.executeSQLStatement(statement)
    }
    
    // Gets path of database containing number of tries per level.
    fileprivate class func getDatabasePath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        return documentsPath.appendingPathComponent(databaseName)
    }
    
    // Creates a new row for level if not exist with 0 tries and best 999.
    class func createLevelIfNotExist(_ level: Int) {
        let countStatement = "select count(level) from tries where level = \(level);"
        let rowsForLevel = Database.executeSQLStatement(countStatement)
        
        if (rowsForLevel == 0) {
            let createStatement = "insert into tries (level, tries, best) values (\(level), 0, 999);"
            Database.executeSQLStatement(createStatement)
        }
    }
    
    // Executes a SQL statement directly without checking.
    // Returns first column of first row of result of query if result is not empty.
    @discardableResult
    fileprivate class func executeSQLStatement(_ stringStatement: String) -> Int {
        var result = -1
        let databasePath = Database.getDatabasePath()
        
        // Open database.
        var db: OpaquePointer? = nil
        
        if sqlite3_open(databasePath, &db) != SQLITE_OK {
            print("Error opening database.")
        }
        
        // Prepare statement.
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, stringStatement, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error preparing insert: \(errmsg)")
        }
        
        // Get result.
        if sqlite3_step(statement) == SQLITE_ROW {
            result = Int(sqlite3_column_int64(statement, 0))
        }
        
        // Clean after statement execution.
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("error finalizing prepared statement: \(errmsg)")
        }
        statement = nil
        if sqlite3_close(db) != SQLITE_OK {
            print("error closing database")
        }
        db = nil
        
        return result
    }
}
