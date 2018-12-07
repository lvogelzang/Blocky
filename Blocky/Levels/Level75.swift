//
//  Level75.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-12-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level75: Level {

	let levelNumber = 75
	var tiles = [[0, 1, 0, 1, 0], [1, 1, 1, 1, 1], [0, 1, 0, 1, 0], [0, 1, 0, 1, 0]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (0, 1), endLocation: (4, 1))

		let pattern0 = [("S", 0.5), ("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (1, 3), animationPattern: pattern0)
		
		let pattern1 = [("S", 0.5), ("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5)]
		let enemy1 = Enemy(enemyNumber: 1, startLocation: (3, 3), animationPattern: pattern1)
		
		enemies = [enemy0, enemy1]

		foods = []
	}
}
