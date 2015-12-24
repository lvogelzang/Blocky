//
//  Scene5Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 02-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene5Controller: SceneController {
    
    required init (mainViewController: MainViewController, sceneNumber: Int) {
        
        super.init(mainViewController: mainViewController, sceneNumber: sceneNumber)
        
        self.cameraFollowsBlock = false
        
        let pattern0 = [("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5)]
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (2,2), animationPattern: pattern0)
        
        let tiles = [[1,1,1,1,1],[0,0,1,0,0],[0,0,1,0,0]]
        
        blocky = Blocky(tiles: tiles, startLocation: (0,0), endLocation: (4,0))
        enemies = [enemy0]
        foods = []
        
    }
    
}