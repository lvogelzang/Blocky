//
//  Scene19Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-09-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

class Scene19Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        cameraFollowsBlock = false
        
        let tiles = [[0,1,1,1,1,1,1,1,0],[0,1,0,0,1,0,0,1,0],[0,1,0,0,1,0,0,1,0],[0,1,1,1,1,1,1,1,0],[0,1,0,0,1,0,0,1,0],[0,1,0,0,1,0,0,1,0],[1,1,1,1,1,1,1,1,1]]
        
        blocky = Blocky(tiles: tiles, startLocation: (0,6), endLocation: (8,6))
        enemies = []
        foods = []
        
    }
    
}
