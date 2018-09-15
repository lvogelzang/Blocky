//
//  Level8.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 26-08-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level8: Level {

	let levelNumber = 8
	var tiles = [[1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 0], [1, 1, 1, 1, 1, 1], [0, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 0], [1, 1, 1, 1, 1, 1]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (5, 0), endLocation: (5, 6))

		let pattern0 = [("S", 0.8), ("S", 0.8), ("N", 0.8), ("N", 0.8)]
		let enemy0 = Enemy(enemyNumber: 0, startLocation: (4, 2), animationPattern: pattern0)
		
		let pattern1 = [("S", 1.6), ("S", 1.6), ("N", 1.6), ("N", 1.6)]
		let enemy1 = Enemy(enemyNumber: 1, startLocation: (3, 2), animationPattern: pattern1)
		
		let pattern2 = [("S", 2.0), ("S", 2.0), ("N", 2.0), ("N", 2.0)]
		let enemy2 = Enemy(enemyNumber: 2, startLocation: (2, 2), animationPattern: pattern2)
		
		let pattern3 = [("S", 2.4), ("S", 2.4), ("N", 2.4), ("N", 2.4)]
		let enemy3 = Enemy(enemyNumber: 3, startLocation: (1, 2), animationPattern: pattern3)
		
		let pattern4 = [("N", 0.8), ("N", 0.8), ("S", 0.8), ("S", 0.8)]
		let enemy4 = Enemy(enemyNumber: 4, startLocation: (4, 4), animationPattern: pattern4)
		
		let pattern5 = [("N", 1.6), ("N", 1.6), ("S", 1.6), ("S", 1.6)]
		let enemy5 = Enemy(enemyNumber: 5, startLocation: (3, 4), animationPattern: pattern5)
		
		let pattern6 = [("N", 2.0), ("N", 2.0), ("S", 2.0), ("S", 2.0)]
		let enemy6 = Enemy(enemyNumber: 6, startLocation: (2, 4), animationPattern: pattern6)
		
		let pattern7 = [("N", 2.4), ("N", 2.4), ("S", 2.4), ("S", 2.4)]
		let enemy7 = Enemy(enemyNumber: 7, startLocation: (1, 4), animationPattern: pattern7)
		
		let pattern8 = [("W", 0.8), ("W", 0.8), ("W", 0.8), ("W", 0.8), ("E", 0.8), ("E", 0.8), ("E", 0.8), ("E", 0.8)]
		let enemy8 = Enemy(enemyNumber: 8, startLocation: (5, 3), animationPattern: pattern8)
		
		enemies = [enemy0, enemy1, enemy2, enemy3, enemy4, enemy5, enemy6, enemy7, enemy8]
		
		foods = []
	}
}
