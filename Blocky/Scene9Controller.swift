//
//  Scene9Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 17-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene9Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        cameraFollowsBlock = false
        
        let tiles = [[1,1,1,1,1,1,1], [0,0,0,1,0,0,0]]
        
        let pattern0 = [("W", 0.5), ("W", 0.5), ("W", 0.5), ("W", 0.5), ("E", 0.5), ("E", 0.5), ("E", 0.5), ("E", 0.5)]
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (5,0), animationPattern: pattern0)
        
        blocky = Blocky(tiles: tiles, startLocation: (6,0), endLocation: (0,0))
        enemies = [enemy0]
        foods = []
        
    }
    
}
