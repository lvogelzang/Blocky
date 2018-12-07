//
//  Level5.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-12-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level5: Level {

	let levelNumber = 5
	var tiles = [[1, 1, 1, 1, 1], [0, 1, 0, 1, 0], [0, 1, 1, 1, 0]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (0, 0), endLocation: (4, 0))

		let pattern0 = [("E", 0.5), ("E", 0.5), ("W", 0.5), ("W", 0.5)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (1, 2), animationPattern: pattern0)
		
		enemies = [enemy0]

		let food0 = Food(foodNumber: 0)
		let food1 = Food(foodNumber: 1)

		foods = [food0, food1]
	}
}
