//
//  Level0.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 18-08-18
//  Copyright (c) 2018 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

final class Level0: Level {

	let levelNumber = 0
	var tiles = [[1, 1, 1, 1, 1]]
	let cameraFollowsBlock = false

	let blocky: Blocky
	let enemies: [Enemy]
	let foods: [Food]

	init() {
		blocky = Blocky(startLocation: (0, 0), endLocation: (4, 0))

		enemies = []
		
		foods = []
	}
}
