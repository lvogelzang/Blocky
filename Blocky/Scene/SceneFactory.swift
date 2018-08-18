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
        return [0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
                20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
                30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
                40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
                50, 51, 52, 53, 54, 55, 56, 57, 58, 59,
                60, 61, 62, 63, 64, 65, 66, 67, 68, 69,
                70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
                80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
                90, 91, 92, 93, 94, 95, 96, 97, 98, 99
        ]
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
