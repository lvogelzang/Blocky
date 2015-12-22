//
//  Scene10Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 17-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene10Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        cameraFollowsBlock = false
        
        let tiles = [[0,0,1,0,0], [1,1,1,1,1], [1,1,1,1,1], [1,1,1,1,1], [1,1,1,1,1], [1,1,1,1,1], [0,0,1,0,0]]
        
        let pattern0 = [("S", 0.5), ("S", 0.5), ("W", 0.5), ("W", 0.5), ("N", 0.5), ("N", 0.5), ("E", 0.5), ("E", 0.5)]
        let pattern1 = [("E", 0.5), ("E", 0.5), ("N", 0.5), ("N", 0.5), ("W", 0.5), ("W", 0.5), ("S", 0.5), ("S", 0.5)]
        let pattern2 = [("S", 0.5), ("S", 0.5), ("W", 0.5), ("W", 0.5), ("N", 0.5), ("N", 0.5), ("E", 0.5), ("E", 0.5)]
        let pattern3 = [("E", 0.5), ("E", 0.5), ("N", 0.5), ("N", 0.5), ("W", 0.5), ("W", 0.5), ("S", 0.5), ("S", 0.5)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (2,5), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (2,3), animationPattern: pattern1)
        let enemy2 = Enemy(enemyNumber: 2, startLocation: (4,3), animationPattern: pattern2)
        let enemy3 = Enemy(enemyNumber: 3, startLocation: (0,1), animationPattern: pattern3)
        
        blocky = Blocky(tiles: tiles, startLocation: (2,6), endLocation: (2,0))
        enemies = [enemy0, enemy1, enemy2, enemy3]
        foods = []
        
    }
    
}