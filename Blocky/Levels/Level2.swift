//
//  Level2.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-12-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level2: Level {

	let levelNumber = 2
	var tiles = [[1, 1, 1, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1, 1, 0], [0, 1, 1, 1, 1, 1, 1, 0], [0, 1, 1, 1, 1, 1, 1, 0], [0, 1, 1, 1, 1, 1, 1, 0]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (0, 0), endLocation: (7, 0))

		let pattern0 = [("S", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (1, 4), animationPattern: pattern0)
		
		let pattern1 = [("N", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5)]
		let enemy1 = Enemy(enemyNumber: 1, startLocation: (2, 0), animationPattern: pattern1)
		
		let pattern2 = [("S", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5)]
		let enemy2 = Enemy(enemyNumber: 2, startLocation: (3, 4), animationPattern: pattern2)
		
		let pattern3 = [("N", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5)]
		let enemy3 = Enemy(enemyNumber: 3, startLocation: (4, 0), animationPattern: pattern3)
		
		let pattern4 = [("S", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5)]
		let enemy4 = Enemy(enemyNumber: 4, startLocation: (5, 4), animationPattern: pattern4)
		
		let pattern5 = [("N", 0.5), ("N", 0.5), ("N", 0.5), ("N", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5), ("S", 0.5)]
		let enemy5 = Enemy(enemyNumber: 5, startLocation: (6, 0), animationPattern: pattern5)
		
		enemies = [enemy0, enemy1, enemy2, enemy3, enemy4, enemy5]

		foods = []
	}
}
