//
//  Scene15Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 22-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level15: Level {
    
    let levelNumber = 15
    var tiles = [[0,2,1,1,0,0],[0,1,0,1,1,1],[1,1,0,1,1,1],[0,1,0,1,1,1],[0,2,1,1,0,0]]
    let cameraFollowsBlock = false
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        let food0 = Food(foodNumber: 0)
        let food1 = Food(foodNumber: 1)
        
        let speed0 = 0.9
        
        let pattern0 = [("N", speed0), ("H", 0.3), ("N", speed0), ("S", speed0), ("H", 0.3), ("S", speed0)]
        let pattern1 = [("S", speed0), ("H", 0.3), ("S", speed0), ("N", speed0), ("H", 0.3), ("N", speed0)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (3,1), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (4,3), animationPattern: pattern1)
        
        blocky = Blocky(startLocation: (0,2), endLocation: (0,2))
        enemies = [enemy0, enemy1]
        foods = [food0, food1]
        
    }
    
}