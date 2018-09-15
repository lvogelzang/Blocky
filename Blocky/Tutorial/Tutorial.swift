//
//  Level0.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 18-08-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Tutorial: Level {

	let levelNumber = -1
	var tiles = [[1, 1, 1, 1, 1]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	var enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (0, 0), endLocation: (4, 0))

        let pattern0 = [("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5)]
        let enemy0 = Enemy(enemyNumber: 0, startLocation: (10, 4), animationPattern: pattern0)
        
		enemies = [enemy0]
		
		foods = []
	}
}
