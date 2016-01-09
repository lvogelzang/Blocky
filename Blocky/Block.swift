//
//  Block.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

// Protocol for game bodies like Blocky, Enemy and Food.
protocol Block {
    
    func reset()
    
}

extension Block {
    
    // Reset scene, used when retrying after died, puts block subclass back.
    func resetNodeLocation(node: SCNNode, startLocation: (Int, Int)) {
        
        let (startX, startY) = startLocation
        let xBy = Float(startX) - node.position.x
        let yBy = Float(startY) - node.position.y
        let zBy = 0.4 - node.position.z
        
        let moveAnimation = SCNAction.moveBy(SCNVector3Make(xBy, yBy, zBy), duration: 0)
        let rotationAnimation = SCNAction.rotateToAxisAngle(SCNVector4Zero, duration: 0)
        let backAnimation = SCNAction.group([moveAnimation, rotationAnimation])
        
        node.removeAllActions()
        node.runAction(backAnimation)
        
    }
    
}
