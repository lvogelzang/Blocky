//
//  Scene13Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 22-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level13: Level {
    
    let levelNumber = 13
    var tiles = [[0,1,1,1,1,1,0],[0,1,1,1,1,1,0],[1,1,1,1,1,1,1],[0,1,1,1,1,1,0],[0,1,1,1,1,1,0]]
    let cameraFollowsBlock = false
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        let speed1 = 1.0
        let speed2 = 0.8
        let speed3 = 0.6
        
        let pattern0 = [("S", speed1), ("S", speed1), ("S", speed1), ("S", speed1), ("N", speed1), ("N", speed1), ("N", speed1), ("N", speed1)]
        let pattern1 = [("S", speed2), ("S", speed2), ("S", speed2), ("S", speed2), ("N", speed2), ("N", speed2), ("N", speed2), ("N", speed2)]
        let pattern2 = [("S", speed3), ("S", speed3), ("S", speed3), ("S", speed3), ("N", speed3), ("N", speed3), ("N", speed3), ("N", speed3)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (1,4), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (2,4), animationPattern: pattern1)
        let enemy2 = Enemy(enemyNumber: 2, startLocation: (3,4), animationPattern: pattern2)
        let enemy3 = Enemy(enemyNumber: 3, startLocation: (4,4), animationPattern: pattern1)
        let enemy4 = Enemy(enemyNumber: 4, startLocation: (5,4), animationPattern: pattern0)
        
        let food0 = Food(foodNumber: 0)
        let food1 = Food(foodNumber: 1)
        let food2 = Food(foodNumber: 2)
        let food3 = Food(foodNumber: 3)
        let food4 = Food(foodNumber: 4)
        
        blocky = Blocky(startLocation: (0,2), endLocation: (6,2))
        enemies = [enemy0, enemy1, enemy2, enemy3, enemy4]
        foods = [food0, food1, food2, food3, food4]
        
    }
    
}