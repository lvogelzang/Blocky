//
//  Level7.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 26-08-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level7: Level {

	let levelNumber = 7
	var tiles = [[0, 1, 1, 1, 1, 1, 0], [0, 1, 1, 1, 1, 1, 0], [1, 1, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1, 0], [0, 1, 1, 1, 1, 1, 0]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (0, 2), endLocation: (6, 2))

		let pattern0 = [("S", 1.0), ("S", 1.0), ("S", 1.0), ("S", 1.0), ("N", 1.0), ("N", 1.0), ("N", 1.0), ("N", 1.0), ("N", 1.0)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (1, 4), animationPattern: pattern0)
		
		let pattern1 = [("S", 0.8), ("S", 0.8), ("S", 0.8), ("S", 0.8), ("N", 0.8), ("N", 0.8), ("N", 0.8), ("N", 0.8), ("N", 0.8)]
		let enemy1 = Enemy(enemyNumber: 1, startLocation: (2, 4), animationPattern: pattern1)
		
		let pattern2 = [("S", 0.6), ("S", 0.6), ("S", 0.6), ("S", 0.6), ("N", 0.6), ("N", 0.6), ("N", 0.6), ("N", 0.6), ("N", 0.6)]
		let enemy2 = Enemy(enemyNumber: 2, startLocation: (3, 4), animationPattern: pattern2)
		
		let pattern3 = [("S", 0.8), ("S", 0.8), ("S", 0.8), ("S", 0.8), ("N", 0.8), ("N", 0.8), ("N", 0.8), ("N", 0.8), ("N", 0.8)]
		let enemy3 = Enemy(enemyNumber: 3, startLocation: (4, 4), animationPattern: pattern3)
		
		let pattern4 = [("S", 1.0), ("S", 1.0), ("S", 1.0), ("S", 1.0), ("N", 1.0), ("N", 1.0), ("N", 1.0), ("N", 1.0), ("N", 1.0)]
		let enemy4 = Enemy(enemyNumber: 4, startLocation: (5, 4), animationPattern: pattern4)
		
		enemies = [enemy0, enemy1, enemy2, enemy3, enemy4]
		
		foods = []
	}
}
