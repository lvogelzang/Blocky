//
//  Animations.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 08-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

// Utility class for getting default block animations
class Animations: NSObject {
   
    // Return default move animation for a block: move, rotate and jump animations combined
    class func getDefaultBlockAnimation(direction direction: Direction, duration: Double) -> SCNAction {
        
        let move = getDefaultMove(direction: direction, duration: duration)
        let rotation = getDefaultRotation(direction: direction, duration: duration)
        let jump = getDefaultJump(duration)
        
        return SCNAction.group([move, rotation, jump]);
        
    }
    
    // Get default move animation, without jump or rotation
    class func getDefaultMove(direction direction: Direction, duration: Double) -> SCNAction {
        
        var xMove:CFloat = 0
        var yMove:CFloat = 0
        
        switch (direction) {
            
        case Direction.North:
            yMove = 1
        case Direction.East:
            xMove = 1
        case Direction.South:
            yMove = -1
        case Direction.West:
            xMove = -1
            
        }
        
        let moveVector = SCNVector3Make(xMove, yMove, 0.0)
        
        return SCNAction.moveBy(moveVector, duration: duration)
        
    }
    
    // Get rotation animation for default block animation
    private class func getDefaultRotation(direction direction: Direction, duration: Double) -> SCNAction {
        
        var xMove:CFloat = 0
        var yMove:CFloat = 0
        var angle:CGFloat = 0
        
        switch (direction) {
            
        case Direction.North:
            yMove = 1
            angle = -CGFloat(M_PI)
        case Direction.East:
            xMove = 1
            angle = CGFloat(M_PI)
        case Direction.South:
            yMove = -1
            angle = CGFloat(M_PI)
        case Direction.West:
            xMove = -1
            angle = -CGFloat(M_PI)
            
        }
        
        let rotateAxis:SCNVector3 = SCNVector3Make(abs(yMove), abs(xMove), 0)
        
        return SCNAction.rotateByAngle(angle, aroundAxis: rotateAxis, duration: duration)
        
    }
    
    // Get jump animation for default block animation
    private class func getDefaultJump(duration: Double) -> SCNAction {
        
        let jumpVector = SCNVector3Make(0, 0, 0.5)
        let jumpUp = SCNAction.moveBy(jumpVector, duration: (0.5 * duration))
        jumpUp.timingMode = SCNActionTimingMode.EaseOut
        
        return SCNAction.sequence([jumpUp, jumpUp.reversedAction()])
        
    }
    
}
