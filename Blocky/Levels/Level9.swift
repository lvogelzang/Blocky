//
//  Level9.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-12-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level9: Level {

	let levelNumber = 9
	var tiles = [[0, 0, 0, 0, 1, 0, 0, 0, 0], [1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1], [0, 0, 0, 0, 1, 0, 0, 0, 0]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (0, 2), endLocation: (8, 3))

		let pattern0 = [("s", 0.5), ("s", 0.5), ("n", 0.5), ("n", 0.5)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (1, 3), animationPattern: pattern0)
		
		let pattern1 = [("n", 0.5), ("s", 0.5), ("s", 0.5), ("n", 0.5)]
		let enemy1 = Enemy(enemyNumber: 1, startLocation: (2, 2), animationPattern: pattern1)
		
		let pattern2 = [("n", 0.5), ("n", 0.5), ("s", 0.5), ("s", 0.5)]
		let enemy2 = Enemy(enemyNumber: 2, startLocation: (3, 1), animationPattern: pattern2)
		
		let pattern3 = [("s", 0.5), ("s", 0.5), ("s", 0.5), ("s", 0.5), ("n", 0.5), ("n", 0.5), ("n", 0.5), ("n", 0.5)]
		let enemy3 = Enemy(enemyNumber: 3, startLocation: (4, 4), animationPattern: pattern3)
		
		let pattern4 = [("n", 0.5), ("n", 0.5), ("s", 0.5), ("s", 0.5)]
		let enemy4 = Enemy(enemyNumber: 4, startLocation: (5, 1), animationPattern: pattern4)
		
		let pattern5 = [("s", 0.5), ("n", 0.5), ("n", 0.5), ("s", 0.5)]
		let enemy5 = Enemy(enemyNumber: 5, startLocation: (6, 2), animationPattern: pattern5)
		
		let pattern6 = [("s", 0.5), ("s", 0.5), ("n", 0.5), ("n", 0.5)]
		let enemy6 = Enemy(enemyNumber: 6, startLocation: (7, 3), animationPattern: pattern6)
		
		enemies = [enemy0, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6]

		foods = []
	}
}
