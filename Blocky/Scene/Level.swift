//
//  Scene.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 25-12-15.
//  Copyright © 2015 Lodewijck Vogelzang. All rights reserved.
//

protocol Level {
    var levelNumber: Int { get }
    var tiles: [[Int]] { get set } // 0: No tile. 1: Normal tile. 2: Breakable tile. 3: Broken tile.
    var cameraFollowsBlock: Bool { get }
    
    var blocky: Blocky { get }
    var enemies: [Enemy] { get }
    var foods: [Food] { get }
    
    init()
}

extension Level {
    func getSceneName() -> String {
        if (levelNumber == -1) {
            return "Tutorial"
        } else {
            return "Level\(levelNumber)"
        }
    }
}
