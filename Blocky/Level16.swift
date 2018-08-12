//
//  Scene16Controller.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 22-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level16: Level {
    
    let levelNumber = 16
    var tiles = [[2,2,2,2,2,2,2],[2,0,2,0,2,0,2],[2,2,2,2,2,2,2],[0,2,2,0,2,2,0],[0,0,2,1,2,0,0]]
    let cameraFollowsBlock = false
    
    let blocky: Blocky
    let enemies: [Enemy]
    let foods: [Food]
    
    init() {
        
        let food0 = Food(foodNumber: 0)
        let food1 = Food(foodNumber: 1)
        
        let food2 = Food(foodNumber: 2)
        let food3 = Food(foodNumber: 3)
        let food4 = Food(foodNumber: 4)
        let food5 = Food(foodNumber: 5)
        
        let food6 = Food(foodNumber: 6)
        let food7 = Food(foodNumber: 7)
        
        let food8 = Food(foodNumber: 8)
        let food9 = Food(foodNumber: 9)
        
        blocky = Blocky(startLocation: (3,4), endLocation: (3,4))
        enemies = []
        foods = [food0, food1, food2, food3, food4, food5, food6, food7, food8, food9]
        
    }
    
}