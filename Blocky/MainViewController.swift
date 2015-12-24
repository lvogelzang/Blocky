//
//  GameViewController.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 16-07-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var tempSceneView: SCNView!
    @IBOutlet weak var menuView: UIView!
    
    weak var sceneController: SceneController?
    
    // MARK: - Initializing
    
    override func viewDidLoad() {
        
        loadLevel(0)
        
        super.viewDidLoad()
        
        sceneView.antialiasingMode = SCNAntialiasingMode.Multisampling4X
        tempSceneView.antialiasingMode = SCNAntialiasingMode.Multisampling4X
        
        menuView.hidden = true
        
    }
    
    // On creation of menu view, set a pointer to this main view contoller.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let menuViewController = segue.destinationViewController as? MenuViewController {
            menuViewController.mainViewController = self
        }
        
    }
    
    // MARK: - User interaction
    
    // Handle a tap outside the menu.
    internal func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        // Toggle menu only if not died.
        if (sceneController!.blocky!.died != true) {
            
            toggleMenu()
            
        }
        
    }
    
    // Initialize level, called before showing the level view.
    internal func loadLevel(level: Int) {
        
        // Swap sceneView with tempSceneView.
        let temp = tempSceneView
        tempSceneView = sceneView
        sceneView = temp
        view.bringSubviewToFront(sceneView)
        view.bringSubviewToFront(menuView)
        
        // Hide first scene view.
        sceneView.alpha = 0
        
        // Set new scene to first scene first.
        sceneController?.unload()
        sceneController = SceneFactory.createScene(self, level: level)
        sceneView.scene = sceneController!.scene
        sceneView.scene?.paused = true
        
        // Fade in new scene, remove old scene after fading in.
        UIView.animateWithDuration(0.25,
            animations: { self.sceneView.alpha = 1 },
            completion: { (completed: Bool) in self.tempSceneView.scene = nil }
        )
        
        // Add gesture recognizers.
        let panGestureRecognizer = UIPanGestureRecognizer(target: sceneController!.blocky!, action: "handlePan:")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        sceneView.gestureRecognizers = [panGestureRecognizer, tapGestureRecognizer]
        
    }
    
    // Toggle visibility of menu.
    internal func toggleMenu() {
        
        if (menuView.hidden == true) {
            
            // Show menu.
            sceneView.scene?.paused = true
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.menuView.hidden = false
            })
            
        } else {
            
            // Hide menu.
            sceneView.scene?.paused = false
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.menuView.hidden = true
            })
            
        }
        
    }
    
}
