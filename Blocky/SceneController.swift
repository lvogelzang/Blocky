//
//  DefaultSceneController.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 02-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import SceneKit

class SceneController: NSObject, SCNPhysicsContactDelegate {
    
    let mainViewController: MainViewController
    var level: Level
    let scene: SCNScene
    let cameraStartPosition: SCNVector3
    
    var won: Bool = false
    
    // Initializes scene controller, does not yet load scene.
    required init (mainViewController: MainViewController, level: Level) {
        
        self.mainViewController = mainViewController
        self.level = level
        
        scene = SCNScene(named: "Scene\(level.levelNumber)")!
        cameraStartPosition = scene.rootNode.childNodeWithName("Camera", recursively: false)!.position
        
        super.init()
        
        scene.paused = true
        scene.physicsWorld.contactDelegate = self
        scene.physicsWorld.gravity = SCNVector3Zero
        
        level.blocky.node = getNodeNamed("Block")
        level.blocky.node!.physicsBody = createBoxPhysicsBody(categoryBitMask: 1, collisionBitMask: 2 | 3)
        
        for enemy: Enemy in level.enemies {
            enemy.node = getNodeNamed("Enemy\(enemy.enemyNumber)")
            enemy.node!.physicsBody = createBoxPhysicsBody(categoryBitMask: 2, collisionBitMask: 1)
            enemy.addAnimation()
        }
        
        for food: Food in level.foods {
            food.node = getNodeNamed("Food\(food.foodNumber)")
            food.node!.physicsBody = createBoxPhysicsBody(categoryBitMask: 3, collisionBitMask: 1)
        }
        
    }
    
    // Reset scene, called when retrying level after one died.
    internal func reset() {
        
        level.blocky.reset()
        
        for enemy: Enemy in level.enemies {
            enemy.reset()
        }
        
        for food: Food in level.foods {
            food.reset()
        }
        
        // Animate camera back.
        if (level.cameraFollowsBlock) {
            
            let camera = getNodeNamed("Camera")
            let cameraAnimation = SCNAction.moveTo(cameraStartPosition, duration: 0.2)
            camera.removeAllActions()
            camera.runAction(cameraAnimation)
            
        }
        
        // Put breakable tiles back.
        for y in 0 ..< level.tiles.count {
            
            for x in 0 ..< level.tiles[0].count {
                
                if (level.tiles[y][x] == 3) {
                    
                    getNodeNamed("Tile\(x)_\(y)").hidden = false
                    
                    level.tiles[y][x] = 2
                    
                }
                
            }
            
        }
        
    }
    
    internal func setPaused(paused: Bool) {
        
        scene.paused = paused
        
    }
    
    // Handles pan as default game control gesture.
    internal func handlePan(gestureRecognizer: UIGestureRecognizer) {
        
        if (level.blocky.isAnimating == false) {
            
            let panGesture = gestureRecognizer as! UIPanGestureRecognizer
            let velocity = panGesture.velocityInView(gestureRecognizer.view)
            let direction = pangestureToDirection(velocity)
            
            if (canMoveInDirection(direction)) {
                
                breakTileIfNeeded()
                level.blocky.location = newLocation(level.blocky.location, direction: direction)
                move(direction)
                
            }
            
        }
        
    }
    
    // Determines in which direction is panned.
    internal func pangestureToDirection(panVelocity: CGPoint) -> Direction {
        
        let xVelocity = panVelocity.x
        let yVelocity = panVelocity.y
        
        // If horizontal movement is bigger.
        if (abs(xVelocity) > abs(yVelocity)) {
            if (xVelocity > 0) {
                return Direction.East
            } else {
                return Direction.West
            }
        }
            
        // If vertical movement is bigger.
        else {
            if (yVelocity < 0) {
                return Direction.North
            } else {
                return Direction.South
            }
        }
        
    }
    
    // Checks if block can move in given direction, based on map.
    private func canMoveInDirection(direction: Direction) -> Bool {
        
        let (newX, newY) = newLocation(level.blocky.location, direction: direction)
        
        let maxX = level.tiles.first!.count - 1
        let maxY = level.tiles.count - 1
        
        // If not outside borders.
        if (newX >= 0 && newX <= maxX && newY >= 0 && newY <= maxY) {
            
            // If new position is a normal tile or a breakable tile.
            if (level.tiles[newY][newX] == 1 || level.tiles[newY][newX] == 2) {
                
                return true
                
            }
            
        }
        
        return false
        
    }
    
    // Returns location after one move in given direction from given location.
    private func newLocation(currentLocation: (Int, Int), direction: Direction) -> (Int, Int) {
        
        let (oldX, oldY) = currentLocation
        
        switch(direction) {
            
        case Direction.North: return (oldX, oldY+1)
        case Direction.East: return (oldX+1, oldY)
        case Direction.South: return (oldX, oldY-1)
        case Direction.West: return (oldX-1, oldY)
            
        }
        
    }
    
    private func move(direction: Direction) {
        
        if (level.blocky.started == false) {
            level.blocky.started = true
            Database.incrementTriesForLevel(level.levelNumber)
        }
        
        // Animate block.
        let blockAnimation = AnimationFactory.getDefaultBlockAnimation(direction: direction, duration: 0.5)
        
        level.blocky.isAnimating = true
        level.blocky.node!.runAction(blockAnimation, completionHandler: {
            
            self.level.blocky.isAnimating = false
            
            // If Block is on end location.
            if (self.level.blocky.location.0 == self.level.blocky.endLocation.0 &&
                self.level.blocky.location.1 == self.level.blocky.endLocation.1) {
                    
                // Check if Block has eaten all foods.
                var ateAllFoods = true
                
                for food: Food in self.level.foods {
                    
                    if (food.eaten == false) {
                        
                        ateAllFoods = false
                        
                    }
                    
                }
                
                if (ateAllFoods == true) {
                    
                    self.win()
                    
                }
                
            }
            
        })
        
        // Animate camera if needed.
        if (level.cameraFollowsBlock) {
            
            let camera = getNodeNamed("Camera")
            let cameraAnimation = AnimationFactory.getDefaultMove(direction: direction, duration: 0.5)
            camera.runAction(cameraAnimation)
            
        }
        
    }
    
    // Makes tile invisble if old tile was breakable.
    private func breakTileIfNeeded() {
        
        if (level.tiles[level.blocky.location.1][level.blocky.location.0] == 2) {
            
            getNodeNamed("Tile\(level.blocky.location.0)_\(level.blocky.location.1)").hidden = true
            
            level.tiles[level.blocky.location.1][level.blocky.location.0] = 3
            
        }
        
    }
    
    // Returns node with given name from currently loaded scene.
    private func getNodeNamed(name: String) -> SCNNode {
        
        return scene.rootNode.childNodeWithName(name, recursively: false)!
        
    }
    
    // Returns default cube as physics body
    private func createBoxPhysicsBody(categoryBitMask categoryBitMask: Int, collisionBitMask: Int) -> SCNPhysicsBody {
        
        let blockBox = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let blockPhysicsShape = SCNPhysicsShape(geometry: blockBox, options: nil)
        
        let body = SCNPhysicsBody(type: SCNPhysicsBodyType.Kinematic, shape: blockPhysicsShape)
        
        body.categoryBitMask = categoryBitMask
        // Since iOS 9.0 uses contacts instead of collisions. More info in iOS documentation.
        if #available(iOS 9.0, *) {
            body.contactTestBitMask = collisionBitMask
        } else {
            body.collisionBitMask = collisionBitMask
        }
        
        return body
        
    }
    
    // Collision detected between Block and an Enemy.
    func physicsWorld(world: SCNPhysicsWorld, didBeginContact contact: SCNPhysicsContact) {
            
        // If contact with Enemy.
        if (contact.nodeB.physicsBody?.categoryBitMask == 2) {
            
            // Can't die on start location: prevent dying multiple times for multiple collisions.
            if (level.blocky.location.0 != level.blocky.startLocation.0 ||
                level.blocky.location.1 != level.blocky.startLocation.1) {
                
                die()
                
            }
            
        }
            
        // If contact with Food.
        else if (contact.nodeB.physicsBody?.categoryBitMask == 3) {
            
            contact.nodeB.hidden = true
            
        }
        
    }
    
    func win() {
        
        Database.wonLevel(level.levelNumber)
        won = true
        mainViewController.setMenuHidden(false)
        
    }
    
    
    func die() {
        
        reset()
        
    }

}
