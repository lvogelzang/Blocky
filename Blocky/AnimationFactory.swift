//
//  Animations.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 08-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

// Utility class for getting default block animations.
class AnimationFactory: NSObject {
    // Return default move animation for a block: move, rotate and jump animations combined.
    internal class func getDefaultBlockAnimation(direction: Direction, duration: Double) -> SCNAction {
        let move = getDefaultMove(direction: direction, duration: duration)
        let rotation = getDefaultRotation(direction: direction, duration: duration)
        let jump = getDefaultJump(duration)
        
        return SCNAction.group([move, rotation, jump]);
    }
    
    // Get default move animation, without jump or rotation.
    internal class func getDefaultMove(direction: Direction, duration: Double) -> SCNAction {
        var xMove:CFloat = 0
        var yMove:CFloat = 0
        
        switch (direction) {
        case Direction.north:
            yMove = 1
        case Direction.east:
            xMove = 1
        case Direction.south:
            yMove = -1
        case Direction.west:
            xMove = -1
        }
        
        let moveVector = SCNVector3Make(xMove, yMove, 0.0)
        return SCNAction.move(by: moveVector, duration: duration)
    }
    
    // Get rotation animation for default block animation.
    fileprivate class func getDefaultRotation(direction: Direction, duration: Double) -> SCNAction {
        var xMove:CFloat = 0
        var yMove:CFloat = 0
        var angle:CGFloat = 0
        
        switch (direction) {
        case Direction.north:
            yMove = 1
            angle = -CGFloat(Double.pi)
        case Direction.east:
            xMove = 1
            angle = CGFloat(Double.pi)
        case Direction.south:
            yMove = -1
            angle = CGFloat(Double.pi)
        case Direction.west:
            xMove = -1
            angle = -CGFloat(Double.pi)
        }
        
        let rotateAxis:SCNVector3 = SCNVector3Make(abs(yMove), abs(xMove), 0)
        return SCNAction.rotate(by: angle, around: rotateAxis, duration: duration)
    }
    
    // Get jump animation for default block animation.
    fileprivate class func getDefaultJump(_ duration: Double) -> SCNAction {
        let jumpVector = SCNVector3Make(0, 0, 0.5)
        let jumpUp = SCNAction.move(by: jumpVector, duration: (0.5 * duration))
        jumpUp.timingMode = SCNActionTimingMode.easeOut
        
        return SCNAction.sequence([jumpUp, jumpUp.reversed()])
    }
}
