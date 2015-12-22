//
//  Food.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Food: Block {
    
    let foodNumber: Int!
   
    init(foodNumber: Int, startLocation: (Int, Int)) {
        
        self.foodNumber = foodNumber
        
        super.init()
        
        self.startLocation = startLocation
        
    }
    
    override func load(sceneController: SceneController) {
        
        super.load(sceneController)
        
        node = getNodeNamed("Food\(foodNumber)")
        node!.physicsBody = createBoxPhysicsBody(categoryBitMask: 3, collisionBitMask: 1)
        
    }
    
    // Returns default cube as physics body
    override func createBoxPhysicsBody(categoryBitMask categoryBitMask: Int, collisionBitMask: Int) -> SCNPhysicsBody {
        
        let blockBox = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let blockPhysicsShape = SCNPhysicsShape(geometry: blockBox, options: nil)
        
        let body = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: blockPhysicsShape)
        
        body.categoryBitMask = categoryBitMask
        body.collisionBitMask = collisionBitMask
        
        return body
        
    }
    
}
