//
//  Enemy.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Enemy: Block {
   
    var animationPattern: [(String, Double)]
    var enemyNumber: Int
    
    init(enemyNumber: Int, startLocation: (Int, Int), animationPattern: [(String, Double)]) {
        
        self.enemyNumber = enemyNumber
        self.animationPattern = animationPattern
        
        super.init()
        
        self.startLocation = startLocation
        
    }
    
    override func load(sceneController: SceneController) {
        
        super.load(sceneController)
        
        node = getNodeNamed("Enemy\(enemyNumber)")
        node!.physicsBody = createBoxPhysicsBody(categoryBitMask: 2, collisionBitMask: 1)
        
        addAnimation()
        
    }
    
    func addAnimation() {
        
        var actions = [SCNAction]()
        var directions = [String]()
        var durations = [Double]()
        
        for (directionCharacter, duration) in animationPattern {
            
            switch(directionCharacter) {
                
            case "N": actions.append(Animations.getDefaultBlockAnimation(direction: Direction.North, duration: duration))
            case "E": actions.append(Animations.getDefaultBlockAnimation(direction: Direction.East, duration: duration))
            case "S": actions.append(Animations.getDefaultBlockAnimation(direction: Direction.South, duration: duration))
            case "W": actions.append(Animations.getDefaultBlockAnimation(direction: Direction.West, duration: duration))
            case "H": actions.append(SCNAction.waitForDuration(duration))
            default: break
                
            }
            
            directions.append(directionCharacter)
            durations.append(duration)
            
        }
        
        let sequence = SCNAction.sequence(actions)
        let loop = SCNAction.repeatActionForever(sequence)
        node!.runAction(loop)
        
    }
    
    override func reset() {
        
        super.reset()
        
        addAnimation()
        
    }
    
}
