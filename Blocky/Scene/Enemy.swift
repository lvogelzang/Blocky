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
    var stepPattern: [(String, Double)]
    var currentStep: Int
    var enemyNumber: Int
    var startLocation: (Int, Int)
    var node: SCNNode?
    
    init(enemyNumber: Int, startLocation: (Int, Int), animationPattern: [(String, Double)]) {
        var animationP:[(String, Double)] = []
        var stepP:[(String, Double)] = []
        for move in animationPattern {
            if "NESW".range(of: move.0) != nil {
                animationP.append(move)
            } else {
                stepP.append(move)
            }
        }

        self.enemyNumber = enemyNumber
        self.animationPattern = animationP
        self.stepPattern = stepP
        self.startLocation = startLocation
        self.currentStep = 0
        
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
        
        if (!animationPattern.isEmpty) {
            let sequence = SCNAction.sequence(actions)
            let loop = SCNAction.repeatForever(sequence)
            node!.runAction(loop)
        }

    }
    
    func stepAnimation() {
        if (!stepPattern.isEmpty) {
            let direction = stepPattern[currentStep].0
            let duration = stepPattern[currentStep].1
            
            switch (direction) {
            case "n": node!.runAction(AnimationFactory.getDefaultBlockAnimation(direction: Direction.north, duration: duration))
            case "e": node!.runAction(AnimationFactory.getDefaultBlockAnimation(direction: Direction.east, duration: duration))
            case "s": node!.runAction(AnimationFactory.getDefaultBlockAnimation(direction: Direction.south, duration: duration))
            case "w": node!.runAction(AnimationFactory.getDefaultBlockAnimation(direction: Direction.west, duration: duration))
            default: break
            }
            currentStep = (currentStep + 1) % stepPattern.count
        }
    }

    
    func reset() {
        self.resetNodeLocation(node!, startLocation: startLocation)
        self.currentStep = 0
        addAnimation()
    }
}
