//
//  DefaultSceneController.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 02-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class SceneController: NSObject {
    
    // Scene related values filled in constructor
    let mainViewController: MainViewController
    let sceneNumber: Int
    var scene: SCNScene
    
    // Default values that may be overridden in subclass
    var cameraFollowsBlock = true
    var backgroundColor = UIColor(white: 0.3, alpha: 1.0)
    
    // Should be initialized in subclass
    var cameraStartPosition: SCNVector3?
    var blocky: Blocky?
    var enemies: [Enemy]?
    var foods: [Food]?
    
    // Initializes scene controller, does not yet load scene
    required init (mainViewController: MainViewController, sceneNumber: Int) {
        
        self.mainViewController = mainViewController
        self.sceneNumber = sceneNumber
        self.scene = SCNScene(named: "Scene\(sceneNumber)")!
        
        super.init()
        
    }
    
    // Load scene, called after subclass is initialized
    func load() {
        
        blocky!.load(self)
        
        for enemy: Enemy in enemies! {
            enemy.load(self)
        }
        
        for food: Food in foods! {
            food.load(self)
        }
        
        scene.physicsWorld.contactDelegate = blocky
        scene.physicsWorld.gravity = SCNVector3Zero
        
        cameraStartPosition = blocky?.getNodeNamed("Camera").position
        
    }
    
    // Remove cyclic pointers so that ARC can release scene
    func unload() {
        
        self.blocky!.unload()
        
        for enemy: Enemy in enemies! {
            enemy.unload()
        }
        
    }
    
    // Reset scene, called when retrying level after one died
    func reset() {
        
        self.blocky!.reset()
        
        for enemy: Enemy in enemies! {
            enemy.reset()
        }
        
        scene.paused = false
        
    }
    
}
