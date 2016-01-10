//
//  Scene17Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 22-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level17: Level {
    
    let levelNumber = 17
    var tiles = [[0,0,0,0,1,1,1,0],[0,0,0,0,1,0,1,0],[1,1,1,1,1,1,1,1],[0,1,0,1,0,0,0,0],[0,1,1,1,0,0,0,0]]
    let cameraFollowsBlock = true
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        let speed0 = 0.35
        
        let pattern0 = [("S", speed0), ("S", speed0), ("E", speed0), ("E", speed0), ("N", speed0), ("N", speed0), ("W", speed0), ("W", speed0)]
        let pattern1 = [("E", speed0), ("E", speed0), ("N", speed0), ("N", speed0), ("W", speed0), ("W", speed0), ("S", speed0), ("S", speed0)]
        
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (4,2), animationPattern: pattern0)
        let enemy1 = Enemy(enemyNumber: 1, startLocation: (1,2), animationPattern: pattern1)
        
        blocky = Blocky(startLocation: (7,2), endLocation: (0,2))
        enemies = [enemy0, enemy1]
        foods = []
        
    }
    
}