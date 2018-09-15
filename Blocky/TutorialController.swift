//
//  TutorialController.swift
//  Blocky
//
//  Created by Lodewijck on 19/08/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

import Foundation
import SceneKit

class TutorialController: SceneController {
    
    var targetsReached = 0
    
    required init(mainViewController: MainViewController, level: Level) {
        super.init(mainViewController: mainViewController, level: level)
        fade(["Surface2", "Surface3", "Enemy0"], visible: false, animated: false)
    }
    
    fileprivate func fade(_ names: [String], visible: Bool, animated: Bool) {
        for name in names {
            let node = scene.rootNode.childNode(withName: name, recursively: true)!
            if (animated) {
                node.runAction(visible ? SCNAction.fadeIn(duration: 0.5) : SCNAction.fadeOut(duration: 0.5), completionHandler: {})
            } else {
                node.opacity = visible ? 1 : 0
            }
        }
    }
    
    fileprivate func location(_ original: SCNVector3, _ x: Float, _ y: Float) -> SCNVector3 {
        return SCNVector3(original.x + x, original.y + y, original.z)
    }
    
    override func win() {
        targetsReached += 1
        print(targetsReached)
        if (targetsReached == 1) {
            fade(["Surface1"], visible: false, animated: true)
            fade(["Surface2"], visible: true, animated: true)
            level.tiles = [[0,0,0,0,1,1,1,0,0],
                           [0,0,0,0,0,0,1,0,0],
                           [0,0,0,0,0,0,1,1,1]]
            level.blocky.startLocation = level.blocky.endLocation
            level.blocky.endLocation = (8, 2)
            cameraStartPosition = location(cameraStartPosition, 4, 1)
            moveCamera(to: cameraStartPosition)
            mainViewController.sceneView.play(nil)
        } else if (targetsReached == 2) {
            fade(["Surface2"], visible: false, animated: true)
            fade(["Surface3", "Enemy0"], visible: true, animated: true)
            level.tiles = [[0,0,0,0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,0,0,0,0,0],
                           [0,0,0,0,0,0,0,0,1,1,1,1,1],
                           [0,0,0,0,0,0,0,0,0,0,1,0,0],
                           [0,0,0,0,0,0,0,0,0,0,1,0,0],]
            level.blocky.startLocation = level.blocky.endLocation
            level.blocky.endLocation = (12, 2)
            cameraStartPosition = location(cameraStartPosition, 4, 2)
            moveCamera(to: cameraStartPosition)
            mainViewController.sceneView.play(nil)
        } else {
            Database.setCompletedTutorial()
            mainViewController.setMenuVisible(true)
        }
    }
    
    override func die() {
        reset()
    }
    
}
