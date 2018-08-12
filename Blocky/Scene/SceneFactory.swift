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
    class func sceneForLevel(_ level: Int) -> Int {
        return getSceneArray()[level]
    }
    
    // Create a scene for the specified level.
    class func createScene(_ mainViewController: MainViewController, levelNumber: Int) -> SceneController {
        let sceneNumber = SceneFactory.sceneForLevel(levelNumber)
        let className = "Blocky.Level\(sceneNumber)"
        let levelClass = NSClassFromString(className) as! Level.Type
        let level = levelClass.init()
        
        return SceneController(mainViewController: mainViewController, level: level)
    }
    
}
