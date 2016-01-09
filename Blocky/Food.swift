//
//  Food.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 14-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Food: NSObject, Block {
    
    internal let foodNumber: Int
    internal var eaten: Bool { return node!.hidden }
    internal var node: SCNNode?
   
    init(foodNumber: Int) {
        
        self.foodNumber = foodNumber
        
        super.init()
        
    }
    
    func reset() {
        
        node!.hidden = false
        
    }
    
}
