//
//  SceneFactory.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 02-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

// Utility class for creating scenes corresponding to levels.
class SceneFactory: NSObject {
    
    // Get the array with scenes per pack (items per section).
    class func getSceneArray() -> [Int] {
        
        return [4, 5, 9, 11, 6, 10, 7, 14, 12, 13, 19, 8, 17, 18, 15, 16]
        
    }
    
    // Get the total amount of packs.
    class func getNumberOfLevels() -> Int {
        
        return getSceneArray().count
        
    }
    
    // Map function to get corresponding scene for a given level.
    class func sceneForLevel(level: Int) -> Int {
        
        return getSceneArray()[level]
        
    }
    
    // Create a scene for the specified level.
    class func createScene(levelViewController: LevelViewController, level: Int) -> SceneController {
        
        let sceneNumber = SceneFactory.sceneForLevel(level)
        let className = "Blocky.Scene\(sceneNumber)Controller"
        let controllerClass = NSClassFromString(className) as! SceneController.Type
        let controller = controllerClass.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        controller.load()
        
        return controller
        
    }
    
}
