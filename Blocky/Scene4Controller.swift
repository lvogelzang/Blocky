//
//  Scene4.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 02-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene4Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        let tiles = [[0,0,1,1,1], [0,0,1,0,0], [1,1,1,0,0]]
        
        blocky = Blocky(tiles: tiles, startLocation: (0,2), endLocation: (4,0))
        enemies = []
        foods = []
        
    }
    
}
