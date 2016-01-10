//
//  Scene8Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 16-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level8: Level {
    
    let levelNumber = 8
    var tiles = [[1,2,2], [0,2,2]]
    let cameraFollowsBlock = false
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        let food0 = Food(foodNumber: 0)
        let food1 = Food(foodNumber: 1)
        let food2 = Food(foodNumber: 2)
        
        blocky = Blocky(startLocation: (2,0), endLocation: (0,0))
        enemies = []
        foods = [food0, food1, food2]
        
    }
    
}