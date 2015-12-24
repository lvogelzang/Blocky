//
//  Scene11Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 17-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene11Controller: SceneController {
    
    required init (mainViewController: MainViewController, sceneNumber: Int) {
        
        super.init(mainViewController: mainViewController, sceneNumber: sceneNumber)
        
        cameraFollowsBlock = false
        
        let tiles = [[1,1,1,1,1,1,1,1], [0,1,1,1,1,1,1,0], [0,1,1,1,1,1,1,0], [0,1,1,1,1,1,1,0], [0,1,1,1,1,1,1,0]]
        
        let pattern0 = [("S", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5)]
        let pattern1 = [("N", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (1,4), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (2,0), animationPattern: pattern1)
        let enemy2 = Enemy(enemyNumber: 2, startLocation: (3,4), animationPattern: pattern0)
        let enemy3 = Enemy(enemyNumber: 3, startLocation: (4,0), animationPattern: pattern1)
        let enemy4 = Enemy(enemyNumber: 4, startLocation: (5,4), animationPattern: pattern0)
        let enemy5 = Enemy(enemyNumber: 5, startLocation: (6,0), animationPattern: pattern1)
        
        blocky = Blocky(tiles: tiles, startLocation: (0,0), endLocation: (7,0))
        enemies = [enemy0, enemy1, enemy2, enemy3, enemy4, enemy5]
        foods = []
        
    }
    
}
