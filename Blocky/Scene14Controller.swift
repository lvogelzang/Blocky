//
//  Scene14Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 22-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene14Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        let tiles = [[0,0,0,0,1,0,0,0,1,0,0,0,0],[1,1,1,1,1,1,1,1,1,1,1,1,1],[0,0,1,0,0,0,1,0,0,0,1,0,0]]
        
        let speed1 = 0.5
        
        let pattern0 = [("W", speed1), ("W", speed1), ("W", speed1), ("W", speed1), ("E", speed1), ("W", speed1), ("E", speed1), ("E", speed1), ("E", speed1), ("E", speed1), ("W", speed1), ("E", speed1)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (6,1), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (10,1), animationPattern: pattern0)
        
        let food0 = Food(foodNumber: 0, startLocation: (2,2))
        let food1 = Food(foodNumber: 1, startLocation: (4,0))
        let food2 = Food(foodNumber: 2, startLocation: (6,2))
        let food3 = Food(foodNumber: 3, startLocation: (8,0))
        let food4 = Food(foodNumber: 4, startLocation: (10,2))
        
        blocky = Blocky(tiles: tiles, startLocation: (0,1), endLocation: (12,1))
        enemies = [enemy0, enemy1]
        foods = [food0, food1, food2, food3, food4]
        
    }
    
}
