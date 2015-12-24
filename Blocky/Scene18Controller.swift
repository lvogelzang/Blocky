//
//  Scene18Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-09-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

class Scene18Controller: SceneController {
    
    required init (mainViewController: MainViewController, sceneNumber: Int) {
        
        super.init(mainViewController: mainViewController, sceneNumber: sceneNumber)
        
        cameraFollowsBlock = false
        
        let tiles = [[1,1,1,1,1,1],[1,1,1,1,1,0],[1,1,1,1,1,1],[0,1,1,1,1,1],[1,1,1,1,1,1],[1,1,1,1,1,0],[1,1,1,1,1,1]]
        
        let speed0 = 0.8
        let speed1 = 1.6
        let speed2 = 2.0
        let speed3 = 2.4
        
        let pattern0 = [("S", speed0), ("S", speed0), ("N", speed0), ("N", speed0)]
        let pattern1 = [("S", speed1), ("S", speed1), ("N", speed1), ("N", speed1)]
        let pattern2 = [("S", speed2), ("S", speed2), ("N", speed2), ("N", speed2)]
        let pattern3 = [("S", speed3), ("S", speed3), ("N", speed3), ("N", speed3)]
        
        let pattern4 = [("N", speed0), ("N", speed0), ("S", speed0), ("S", speed0)]
        let pattern5 = [("N", speed1), ("N", speed1), ("S", speed1), ("S", speed1)]
        let pattern6 = [("N", speed2), ("N", speed2), ("S", speed2), ("S", speed2)]
        let pattern7 = [("N", speed3), ("N", speed3), ("S", speed3), ("S", speed3)]
        
        let pattern8 = [("W", speed0), ("W", speed0), ("W", speed0), ("W", speed0), ("E", speed0), ("E", speed0), ("E", speed0), ("E", speed0)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (4,2), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (3,2), animationPattern: pattern1)
        let enemy2 = Enemy(enemyNumber: 2, startLocation: (2,2), animationPattern: pattern2)
        let enemy3 = Enemy(enemyNumber: 3, startLocation: (1,2), animationPattern: pattern3)
        let enemy4 = Enemy(enemyNumber: 4, startLocation: (4,4), animationPattern: pattern4)
        let enemy5 = Enemy(enemyNumber: 5, startLocation: (3,4), animationPattern: pattern5)
        let enemy6 = Enemy(enemyNumber: 6, startLocation: (2,4), animationPattern: pattern6)
        let enemy7 = Enemy(enemyNumber: 7, startLocation: (1,4), animationPattern: pattern7)
        let enemy8 = Enemy(enemyNumber: 8, startLocation: (5,3), animationPattern: pattern8)
        
        let food0 = Food(foodNumber: 0, startLocation: (0,2))
        let food1 = Food(foodNumber: 1, startLocation: (5,2))
        let food2 = Food(foodNumber: 2, startLocation: (5,4))
        let food3 = Food(foodNumber: 3, startLocation: (0,4))
        
        blocky = Blocky(tiles: tiles, startLocation: (5,0), endLocation: (5,6))
        enemies = [enemy0, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, enemy7, enemy8]
        foods = [food0, food1, food2, food3]
        
    }
    
}