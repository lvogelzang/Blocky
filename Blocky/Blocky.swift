//
//  Block.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 07-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class Blocky: Block, SCNPhysicsContactDelegate {
    
    var died = false
    var won = false
    var isAnimating = false
    var location: (Int, Int)
    var tiles:[[Int]] // 0: No tile. 1: Normal tile. 2: Breakable tile. 3: Broken tile.
    var endLocation:(Int, Int)
    
    init(tiles: [[Int]], startLocation: (Int, Int), endLocation: (Int, Int)) {
        
        self.location = startLocation
        self.tiles = tiles
        self.endLocation = endLocation
        
        super.init()
        
        self.startLocation = startLocation
        
    }
    
    override func load(sceneController: SceneController) {
        
        super.load(sceneController)
        
        node = getNodeNamed("Block")
        node!.physicsBody = createBoxPhysicsBody(categoryBitMask: 1, collisionBitMask: 2 | 3)
        
    }
    
    // Reset scene, used when retrying after died
    override func reset() {
        
        // Put Block back
        super.reset()
        
        // Animate camera back
        if (sceneController!.cameraFollowsBlock == true) {
            
            let camera = getNodeNamed("Camera")
            let cameraAnimation = SCNAction.moveTo(sceneController!.cameraStartPosition!, duration: 0.2)
            camera.removeAllActions()
            camera.runAction(cameraAnimation)
            
        }
        
        // Put foods back
        for food: Food in sceneController!.foods! {
            
            food.node?.hidden = false
            
        }
        
        // Put breakable tiles back
        for y in 0..<tiles.count {
            
            for x in 0..<tiles[0].count {
                
                if (tiles[y][x] == 3) {
                    
                    getNodeNamed("Tile\(x)_\(y)").hidden = false
                    
                    tiles[y][x] = 2
                    
                }
                
            }
            
        }
        
        self.isAnimating = false
        self.died = false
        self.won = false
        self.location = self.startLocation
        
    }
    
    // Collision detected between Block and an Enemy
    func physicsWorld(world: SCNPhysicsWorld, didBeginContact contact: SCNPhysicsContact) {
        
        // If not at start location (to avoid collisions on reset)
        if (location.0 != startLocation.0 || location.1 != startLocation.1) {
        
            // If contact with Enemy
            if (contact.nodeB.physicsBody?.categoryBitMask == 2) {
                
                // Can't die on start location: prevent dying multiple times for multiple collisions
                if (location.0 != startLocation.0 || location.1 != startLocation.1) {
                    
                    die()
                    
                }
                
            }
            
            // If contact with Food
            else if (contact.nodeB.physicsBody?.categoryBitMask == 3) {
                
                contact.nodeB.hidden = true
                
                /*if (contact.nodeB.particleSystems == nil) {
                
                    let ps = SCNParticleSystem(named: "Bokeh", inDirectory: nil)
                    
                    contact.nodeB.addParticleSystem(ps)
                    
                }*/
            
            }
        
        }
        
    }
    
    func win() {
        
        won = true
        sceneController!.mainViewController.toggleMenu()
        
    }
    
    func die() {
        
        died = true
        reset()
        
    }
    
}

// Controls
extension Blocky {

    // Handles pan as default game control gesture
    func handlePan(gestureRecognizer: UIGestureRecognizer) {
        
        if (isAnimating == false) {
            
            let panGesture = gestureRecognizer as! UIPanGestureRecognizer
            let velocity = panGesture.velocityInView(gestureRecognizer.view)
            
            let direction = pangestureToDirection(velocity)
            
            if (canMoveInDirection(direction)) {
                
                breakTileIfNeeded()
                location = newLocation(location, direction: direction)
                move(direction)
                
            }
            
        }
        
    }
    
    // Determines in which direction is panned
    func pangestureToDirection(panVelocity: CGPoint) -> Direction {
        
        let xVelocity = panVelocity.x
        let yVelocity = panVelocity.y
        
        // If horizontal movement is bigger
        if (abs(xVelocity) > abs(yVelocity)) {
            if (xVelocity > 0) {
                return Direction.East
            } else {
                return Direction.West
            }
        }
            
        // If vertical movement is bigger
        else {
            if (yVelocity < 0) {
                return Direction.North
            } else {
                return Direction.South
            }
        }
        
    }
    
    // Checks if block can move in given direction, based on map
    func canMoveInDirection(direction: Direction) -> Bool {
        
        let (newX, newY) = newLocation(location, direction: direction)
        
        let maxX = tiles.first!.count - 1
        let maxY = tiles.count - 1
        
        // If not outside borders
        if (newX >= 0 && newX <= maxX && newY >= 0 && newY <= maxY) {
            
            // If new position is a normal tile or a breakable tile
            if (tiles[newY][newX] == 1 || tiles[newY][newX] == 2) {
                
                return true
                
            }
            
        }
        
        return false
        
    }
    
    // Returns location after one move in given direction from given location
    func newLocation(currentLocation: (Int, Int), direction: Direction) -> (Int, Int) {
        
        let (oldX, oldY) = currentLocation
        
        switch(direction) {
            
        case Direction.North: return (oldX, oldY+1)
        case Direction.East: return (oldX+1, oldY)
        case Direction.South: return (oldX, oldY-1)
        case Direction.West: return (oldX-1, oldY)
            
        }
        
    }
    
    func move(direction: Direction) {
        
        // Animate block
        let block = getNodeNamed("Block")
        let blockAnimation = Animations.getDefaultBlockAnimation(direction: direction, duration: 0.5)
        
        isAnimating = true
        block.runAction(blockAnimation, completionHandler: {
            
            self.isAnimating = false
            
            // If Block is on end location
            if (self.location.0 == self.endLocation.0 && self.location.1 == self.endLocation.1) {
                
                var ateAllFoods = true
                
                // If Block has eaten all foods
                for food: Food in self.sceneController!.foods! {
                    
                    if (food.node!.hidden == false) {
                        
                        ateAllFoods = false
                        
                    }
                    
                }
                
                if (ateAllFoods == true) {
                    
                    self.win()
                    
                }
            
            }
            
        })
        
        // Animate camera
        if (sceneController?.cameraFollowsBlock == true) {
            
            let camera = getNodeNamed("Camera")
            let cameraAnimation = Animations.getDefaultMove(direction: direction, duration: 0.5)
            camera.runAction(cameraAnimation)
            
        }
        
    }
    
    // Makes tile invisble if old tile was breakable
    func breakTileIfNeeded() {
            
        if (tiles[location.1][location.0] == 2) {
            
            getNodeNamed("Tile\(location.0)_\(location.1)").hidden = true
            
            tiles[location.1][location.0] = 3
            
        }
    
    }
    
}
