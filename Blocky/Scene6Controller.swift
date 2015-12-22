//
//  Scene6Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 12-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene6Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        let pattern0 = [("E", 0.5), ("E", 0.5), ("E", 0.5), ("W", 0.5), ("W", 0.5), ("W", 0.5)]
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (0,1), animationPattern: pattern0)
        
        let pattern1 = [("W", 0.5), ("W", 0.5), ("W", 0.5), ("E", 0.5), ("E", 0.5), ("E", 0.5)]
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (3,2), animationPattern: pattern1)
        
        let pattern2 = [("E", 0.5), ("E", 0.5), ("E", 0.5), ("W", 0.5), ("W", 0.5), ("W", 0.5)]
        let enemy2 = Enemy(enemyNumber: 2, startLocation: (0,3), animationPattern: pattern2)
        
        
        let pattern3 = [("S", 0.5), ("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5)]
        let enemy3 = Enemy(enemyNumber: 3, startLocation: (4,4), animationPattern: pattern3)
        
        let pattern4 = [("N", 0.5), ("N", 0.5), ("N", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5)]
        let enemy4 = Enemy(enemyNumber: 4, startLocation: (5,1), animationPattern: pattern4)
        
        let pattern5 = [("S", 0.5), ("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5)]
        let enemy5 = Enemy(enemyNumber: 5, startLocation: (6,4), animationPattern: pattern5)
        
        let tiles = [[0,0,0,1,0,0,0,0],[1,1,1,1,1,1,1,0],[1,1,1,1,1,1,1,0],[1,1,1,1,1,1,1,0],[0,0,0,1,1,1,1,1]]
        
        blocky = Blocky(tiles: tiles, startLocation: (3,0), endLocation: (7,4))
        enemies = [enemy0, enemy1, enemy2, enemy3, enemy4, enemy5]
        foods = []
        
    }
    
}
