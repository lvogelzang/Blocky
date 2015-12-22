//
//  Block.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

// Superclass for Blocky and Enemy
class Block: NSObject {
    
    var startLocation = (0, 0)
    var sceneController: SceneController?
    var node: SCNNode?
    
    // Set scene controller after it is subclassed
    func load(sceneController: SceneController) {
        
        self.sceneController = sceneController
        
    }
    
    // Remove all pointers so that ARC can deallocate
    func unload() {
        
        sceneController = nil
    }
    
    // Reset scene, used when retrying after died, puts block subclass back
    func reset() {
        
        let (startX, startY) = startLocation
        let xBy = Float(startX) - node!.position.x
        let yBy = Float(startY) - node!.position.y
        let zBy = 0.4 - node!.position.z
        
        let moveAnimation = SCNAction.moveBy(SCNVector3Make(xBy, yBy, zBy), duration: 0)
        let rotationAnimation = SCNAction.rotateToAxisAngle(SCNVector4Zero, duration: 0)
        let backAnimation = SCNAction.group([moveAnimation, rotationAnimation])
        
        node!.removeAllActions()
        node!.runAction(backAnimation)
        
    }
    
    // Returns default cube as physics body
    func createBoxPhysicsBody(categoryBitMask categoryBitMask: Int, collisionBitMask: Int) -> SCNPhysicsBody {
        
        let blockBox = SCNBox(width: 0.8, height: 0.8, length: 0.8, chamferRadius: 0)
        let blockPhysicsShape = SCNPhysicsShape(geometry: blockBox, options: nil)
        
        let body = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: blockPhysicsShape)
        
        body.categoryBitMask = categoryBitMask
        body.collisionBitMask = collisionBitMask
        
        return body
        
    }
    
    // Returns node with given name from currently loaded scene
    func getNodeNamed(name: String) -> SCNNode {
        
        return sceneController!.scene.rootNode.childNodeWithName(name, recursively: false)!
        
    }
    
}
