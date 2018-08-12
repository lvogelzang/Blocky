//
//  Scene4.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 02-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level4: Level {
        
    let levelNumber = 4
    var tiles = [[0,0,1,1,1], [0,0,1,0,0], [1,1,1,0,0]]
    let cameraFollowsBlock = true
        
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        blocky =  Blocky(startLocation: (0,2), endLocation: (4,0))
        enemies = []
        foods = []
        
    }
    
}
