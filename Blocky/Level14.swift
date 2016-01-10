//
//  Scene14Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 22-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level14: Level {
    
    let levelNumber = 14
    var tiles = [[0,0,0,0,1,0,0,0,1,0,0,0,0],[1,1,1,1,1,1,1,1,1,1,1,1,1],[0,0,1,0,0,0,1,0,0,0,1,0,0]]
    let cameraFollowsBlock = true
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        let speed1 = 0.5
        
        let pattern0 = [("W", speed1), ("W", speed1), ("W", speed1), ("W", speed1), ("E", speed1), ("W", speed1), ("E", speed1), ("E", speed1), ("E", speed1), ("E", speed1), ("W", speed1), ("E", speed1)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (6,1), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (10,1), animationPattern: pattern0)
        
        let food0 = Food(foodNumber: 0)
        let food1 = Food(foodNumber: 1)
        let food2 = Food(foodNumber: 2)
        let food3 = Food(foodNumber: 3)
        let food4 = Food(foodNumber: 4)
        
        blocky = Blocky(startLocation: (0,1), endLocation: (12,1))
        enemies = [enemy0, enemy1]
        foods = [food0, food1, food2, food3, food4]
        
    }
    
}