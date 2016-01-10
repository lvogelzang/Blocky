//
//  Scene7Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level7: Level {
    
    let levelNumber = 7
    var tiles = [[1,1,1,1,1], [0,1,0,1,0], [0,1,1,1,0]]
    let cameraFollowsBlock = false
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        let pattern0 = [("E", 0.5), ("E", 0.5), ("W", 0.5), ("W", 0.5)]
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (0,1), animationPattern: pattern0)
        
        let food0 = Food(foodNumber: 0)
        let food1 = Food(foodNumber: 1)
        
        blocky =  Blocky(startLocation: (0,0), endLocation: (4,0))
        enemies = [enemy0]
        foods = [food0, food1]
        
    }
    
}