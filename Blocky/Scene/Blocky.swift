//
//  Block.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Blocky: NSObject, Block {
    var started = false
    var isAnimating = false
    var location: (Int, Int)
    var startLocation:(Int, Int)
    var endLocation:(Int, Int)
    var node: SCNNode?
    
    init(startLocation: (Int, Int), endLocation: (Int, Int)) {
        location = startLocation
        self.startLocation = startLocation
        self.endLocation = endLocation
        
        super.init()
    }
    
    // Reset blocky after died or when retrying a level.
    func reset() {
        started = false
        isAnimating = false
        location = startLocation
        resetNodeLocation(node!, startLocation: startLocation)
    }
    
}
