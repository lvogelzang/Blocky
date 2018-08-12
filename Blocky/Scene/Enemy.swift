//
//  Enemy.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Enemy: NSObject, Block {
    var animationPattern: [(String, Double)]
    var enemyNumber: Int
    var startLocation: (Int, Int)
    var node: SCNNode?
    
    init(enemyNumber: Int, startLocation: (Int, Int), animationPattern: [(String, Double)]) {
        self.enemyNumber = enemyNumber
        self.animationPattern = animationPattern
        self.startLocation = startLocation
        
        super.init()
    }
    
    func addAnimation() {
        var actions = [SCNAction]()
        var directions = [String]()
        var durations = [Double]()
        
        for (directionCharacter, duration) in animationPattern {
            switch(directionCharacter) {
            case "N": actions.append(AnimationFactory.getDefaultBlockAnimation(direction: Direction.north, duration: duration))
            case "E": actions.append(AnimationFactory.getDefaultBlockAnimation(direction: Direction.east, duration: duration))
            case "S": actions.append(AnimationFactory.getDefaultBlockAnimation(direction: Direction.south, duration: duration))
            case "W": actions.append(AnimationFactory.getDefaultBlockAnimation(direction: Direction.west, duration: duration))
            case "H": actions.append(SCNAction.wait(duration: duration))
            default: break
            }
            
            directions.append(directionCharacter)
            durations.append(duration)
        }
        
        let sequence = SCNAction.sequence(actions)
        let loop = SCNAction.repeatForever(sequence)
        node!.runAction(loop)
    }
    
    func reset() {
        self.resetNodeLocation(node!, startLocation: startLocation)
        addAnimation()
    }
}
