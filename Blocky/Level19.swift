//
//  Scene19Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-09-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level19: Level {
    
    let levelNumber = 19
    var tiles = [[0,1,1,1,1,1,1,1,0],[0,1,0,0,1,0,0,1,0],[0,1,0,0,1,0,0,1,0],[0,1,1,1,1,1,1,1,0],[0,1,0,0,1,0,0,1,0],[0,1,0,0,1,0,0,1,0],[1,1,1,1,1,1,1,1,1]]
    let cameraFollowsBlock = false
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        blocky = Blocky(startLocation: (0,6), endLocation: (8,6))
        enemies = []
        foods = []
        
    }
    
}