//
//  Scene8Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 16-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Scene8Controller: SceneController {
    
    required init (levelViewController: LevelViewController, sceneNumber: Int) {
        
        super.init(levelViewController: levelViewController, sceneNumber: sceneNumber)
        
        cameraFollowsBlock = false
        
        let tiles = [[1,2,2], [0,2,2]]
        
        let food0 = Food(foodNumber: 0, startLocation: (1,0))
        let food1 = Food(foodNumber: 1, startLocation: (1,1))
        let food2 = Food(foodNumber: 2, startLocation: (2,1))
        
        blocky = Blocky(tiles: tiles, startLocation: (2,0), endLocation: (0,0))
        enemies = []
        foods = [food0, food1, food2]
        
    }
    
}