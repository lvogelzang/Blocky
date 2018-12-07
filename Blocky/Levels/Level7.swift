//
//  Level7.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-12-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level7: Level {

	let levelNumber = 7
	var tiles = [[0, 1, 1, 1, 1, 0], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 0], [0, 1, 1, 1, 1, 0]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (0, 2), endLocation: (5, 1))

		let pattern0 = [("s", 0.5), ("e", 0.5), ("n", 0.5), ("w", 0.5)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (1, 3), animationPattern: pattern0)
		
		let pattern1 = [("s", 0.5), ("e", 0.5), ("n", 0.5), ("w", 0.5)]
		let enemy1 = Enemy(enemyNumber: 1, startLocation: (1, 1), animationPattern: pattern1)
		
		let pattern2 = [("s", 0.5), ("e", 0.5), ("n", 0.5), ("w", 0.5)]
		let enemy2 = Enemy(enemyNumber: 2, startLocation: (3, 3), animationPattern: pattern2)
		
		let pattern3 = [("s", 0.5), ("e", 0.5), ("n", 0.5), ("w", 0.5)]
		let enemy3 = Enemy(enemyNumber: 3, startLocation: (3, 1), animationPattern: pattern3)
		
		enemies = [enemy0, enemy1, enemy2, enemy3]

		foods = []
	}
}
