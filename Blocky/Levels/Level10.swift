//
//  Level10.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-12-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level10: Level {

	let levelNumber = 10
	var tiles = [[0, 0, 1, 1, 1, 0, 0], [0, 0, 1, 1, 1, 0, 0], [1, 1, 1, 0, 1, 1, 1], [0, 0, 1, 1, 1, 0, 0], [0, 0, 1, 1, 1, 0, 0], [0, 0, 1, 1, 1, 0, 0]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (6, 2), endLocation: (0, 2))

		let pattern0 = [("W", 0.5), ("E", 0.5), ("E", 0.5), ("W", 0.5)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (3, 0), animationPattern: pattern0)
		
		let pattern1 = [("w", 0.5), ("e", 0.5), ("e", 0.5), ("w", 0.5)]
		let enemy1 = Enemy(enemyNumber: 1, startLocation: (3, 1), animationPattern: pattern1)
		
		let pattern2 = [("w", 0.5), ("e", 0.5), ("e", 0.5), ("w", 0.5)]
		let enemy2 = Enemy(enemyNumber: 2, startLocation: (3, 3), animationPattern: pattern2)
		
		let pattern3 = [("W", 0.5), ("E", 0.5), ("E", 0.5), ("W", 0.5)]
		let enemy3 = Enemy(enemyNumber: 3, startLocation: (3, 4), animationPattern: pattern3)
		
		enemies = [enemy0, enemy1, enemy2, enemy3]

		foods = []
	}
}
