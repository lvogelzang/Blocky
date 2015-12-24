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
    
    // MARK: - Public functions
    
    // Called after player won a scene. Resets number of tries, and recalculates best score.
    class func wonScene(number: Int) {
        
        let triesForScene = Database.getTriesForScene(number)
        var bestForScene = Database.getBestForScene(number)
        
        if (triesForScene + 1 < bestForScene) {
            bestForScene = triesForScene + 1
        }
        
        let wonStatement = "update tries set tries = 0, best = \(bestForScene) where scene = \(number);"
        Database.executeSQLStatementForScene(number, statement: wonStatement)
        
    }
    
    // Increases number of tries for scene.
    class func failedScene(number: Int) {
        
        let triesForScene = Database.getTriesForScene(number)
        let increaseTriesStatement = "update tries set tries = \(triesForScene+1) where scene = \(number);"
        Database.executeSQLStatementForScene(number, statement: increaseTriesStatement)
        
    }
    
    // Gets the amount of tries in the current streak for a scene.
    class func getTriesForScene(number: Int) -> Int {
        
        let getTriesStatement = "select tries from tries where scene = \(number)"
        return Database.executeSQLStatementForScene(number, statement: getTriesStatement)
        
    }
    
    // Gets the minimum amount of tries needed for a scene.
    class func getBestForScene(number: Int) -> Int {
        
        let getBestStatement = "select best from tries where scene = \(number)"
        return Database.executeSQLStatementForScene(number, statement: getBestStatement)
        
    }
    
    // MARK: - Private functions
    
    // First private method called when using the database.
    // Executes a SQL statement without verifying.
    // Creates scene if scene is not known in database yet.
    // Creates database if scene does not exist yet.
    // Returns first result of query if result is not empty.
    private class func executeSQLStatementForScene(number: Int, statement: String) -> Int {
        
        Database.createDatabaseIfNotExist()
        Database.createSceneIfNotExist(number)
        return Database.executeSQLStatement(statement)
        
    }
    
    // Creates a SQL database with an empty table called tries if not exist yet. Built like:
    // Create table tries(scene smallint primary key, tries smallint, best smallint);
    private class func createDatabaseIfNotExist() {
        
        let databasePath = Database.getDatabasePath()
        
        let fileManager = NSFileManager()
        let databaseExists = fileManager.fileExistsAtPath(databasePath)
        
        if (!databaseExists) {
            
            let databasePathFromBundle = (NSBundle.mainBundle().resourcePath! as NSString).stringByAppendingPathComponent(databaseName)
            
            do {
                try fileManager.copyItemAtPath(databasePathFromBundle, toPath: databasePath)
            } catch _ {
                print("Failed to copy database from bundle to app.")
            }
            
        }
        
    }
    
    // Gets path of database containing number of tries per level.
    private class func getDatabasePath() -> String {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        return documentsPath.stringByAppendingPathComponent(databaseName)
        
    }
    
    // Creates a new row for scene if not exist with 0 tries and best 999.
    class func createSceneIfNotExist(number: Int) {
        
        let countStatement = "select count(scene) from tries where scene = \(number);"
        let rowsForScene = Database.executeSQLStatement(countStatement)
        
        if (rowsForScene == 0) {
            
            let createStatement = "insert into tries (scene, tries, best) values (\(number), 0, 999);"
            Database.executeSQLStatement(createStatement)
            
        }
        
    }
    
    // Executes a SQL statement directly without checking.
    // Returns first column of first row of result of query if result is not empty.
    private class func executeSQLStatement(stringStatement: String) -> Int {
        
        var result = -1
        let databasePath = Database.getDatabasePath()
        
        // Open database.
        var db: COpaquePointer = nil
        if sqlite3_open(databasePath, &db) != SQLITE_OK {
            print("Error opening database.")
        }
        
        // Prepare statement.
        var statement: COpaquePointer = nil
        if sqlite3_prepare_v2(db, stringStatement, -1, &statement, nil) != SQLITE_OK {
            let errmsg = String.fromCString(sqlite3_errmsg(db))
            print("error preparing insert: \(errmsg)")
        }
        
        // Get result.
        if sqlite3_step(statement) == SQLITE_ROW {
            result = Int(sqlite3_column_int64(statement, 0))
        }
        
        // Clean after statement execution.
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String.fromCString(sqlite3_errmsg(db))
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
