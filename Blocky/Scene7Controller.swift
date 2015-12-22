//
//  Scene7Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene7Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        cameraFollowsBlock = false
        
        let pattern0 = [("E", 0.5), ("E", 0.5), ("W", 0.5), ("W", 0.5)]
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (0,1), animationPattern: pattern0)
        
        let tiles = [[1,1,1,1,1], [0,1,0,1,0], [0,1,1,1,0]]
        
        let food0 = Food(foodNumber: 0, startLocation: (1,2))
        let food1 = Food(foodNumber: 1, startLocation: (3,2))
        
        blocky = Blocky(tiles: tiles, startLocation: (0,0), endLocation: (4,0))
        enemies = [enemy0]
        foods = [food0, food1]
        
    }
    
}
