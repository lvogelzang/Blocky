//
//  Level4.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-12-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level4: Level {

	let levelNumber = 4
	var tiles = [[0, 0, 1, 0, 0], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1], [0, 0, 1, 0, 0]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (2, 6), endLocation: (2, 0))

		let pattern0 = [("S", 0.5), ("S", 0.5), ("W", 0.5), ("W", 0.5), ("N", 0.5), ("N", 0.5), ("E", 0.5), ("E", 0.5)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (2, 5), animationPattern: pattern0)
		
		let pattern1 = [("E", 0.5), ("E", 0.5), ("N", 0.5), ("N", 0.5), ("W", 0.5), ("W", 0.5), ("S", 0.5), ("S", 0.5)]
		let enemy1 = Enemy(enemyNumber: 1, startLocation: (2, 3), animationPattern: pattern1)
		
		let pattern2 = [("S", 0.5), ("S", 0.5), ("W", 0.5), ("W", 0.5), ("N", 0.5), ("N", 0.5), ("E", 0.5), ("E", 0.5)]
		let enemy2 = Enemy(enemyNumber: 2, startLocation: (4, 3), animationPattern: pattern2)
		
		let pattern3 = [("E", 0.5), ("E", 0.5), ("N", 0.5), ("N", 0.5), ("W", 0.5), ("W", 0.5), ("S", 0.5), ("S", 0.5)]
		let enemy3 = Enemy(enemyNumber: 3, startLocation: (0, 1), animationPattern: pattern3)
		
		enemies = [enemy0, enemy1, enemy2, enemy3]

		foods = []
	}
}
