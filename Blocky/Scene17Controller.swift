//
//  Scene17Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 22-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene17Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        let tiles = [[0,0,0,0,1,1,1,0],[0,0,0,0,1,0,1,0],[1,1,1,1,1,1,1,1],[0,1,0,1,0,0,0,0],[0,1,1,1,0,0,0,0]]
        
        let speed0 = 0.35
        
        let pattern0 = [("S", speed0), ("S", speed0), ("E", speed0), ("E", speed0), ("N", speed0), ("N", speed0), ("W", speed0), ("W", speed0)]
        let pattern1 = [("E", speed0), ("E", speed0), ("N", speed0), ("N", speed0), ("W", speed0), ("W", speed0), ("S", speed0), ("S", speed0)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (4,2), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (1,2), animationPattern: pattern1)
        
        blocky = Blocky(tiles: tiles, startLocation: (7,2), endLocation: (0,2))
        enemies = [enemy0, enemy1]
        foods = []
        
    }
    
}