//
//  Scene9Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 17-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level9: Level {
    
    let levelNumber = 9
    var tiles = [[1,1,1,1,1,1,1], [0,0,0,1,0,0,0]]
    let cameraFollowsBlock = false
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        let pattern0 = [("W", 0.5), ("W", 0.5), ("W", 0.5), ("W", 0.5), ("E", 0.5), ("E", 0.5), ("E", 0.5), ("E", 0.5)]
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (5,0), animationPattern: pattern0)
        
        blocky =  Blocky(startLocation: (6,0), endLocation: (0,0))
        enemies = [enemy0]
        foods = []
        
    }
    
}
