//
//  SceneController.swift
//  Blocky
//
//  Created by Lodewijck on 11/08/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

import UIKit
import SceneKit

let blockyCategory:Int = 1 << 1
let enemyCategory:Int = 1 << 2
let foodCategory:Int = 1 << 3

class SceneController: NSObject, SCNPhysicsContactDelegate {
    let mainViewController: MainViewController
    var level: Level
    let scene: SCNScene
    let cameraStartPosition: SCNVector3
    var lastControl: Control?
    var lastDied: Date = Date(timeIntervalSince1970: 0)
    
    var won: Bool = false
    
    // Initializes scene controller, does not yet load scene.
    required init (mainViewController: MainViewController, level: Level) {
        self.mainViewController = mainViewController
        self.level = level
        
        scene = SCNScene(named: "Level\(level.levelNumber)")!
        cameraStartPosition = scene.rootNode.childNode(withName: "Camera", recursively: false)!.position
        
        super.init()
        
        scene.isPaused = true
        scene.physicsWorld.contactDelegate = self
        scene.physicsWorld.gravity = SCNVector3Zero
        
        level.blocky.node = getNodeNamed("Blocky")
        level.blocky.node!.physicsBody = createBoxPhysicsBody(categoryBitMask: blockyCategory, collisionBitMask: enemyCategory | foodCategory, edge: 0.8)
        
        for enemy: Enemy in level.enemies {
            enemy.node = getNodeNamed("Enemy\(enemy.enemyNumber)")
            enemy.node!.physicsBody = createBoxPhysicsBody(categoryBitMask: enemyCategory, collisionBitMask: blockyCategory, edge:  0.8)
            enemy.addAnimation()
        }
        
        for food: Food in level.foods {
            food.node = getNodeNamed("Food\(food.foodNumber)")
            food.node!.physicsBody = createBoxPhysicsBody(categoryBitMask: foodCategory, collisionBitMask: blockyCategory, edge: 0.2)
        }
    }
    
    // Reset scene, called when retrying level after one died.
    internal func reset() {
        lastControl = nil
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
            let cameraAnimation = SCNAction.move(to: cameraStartPosition, duration: 0.2)
            camera.removeAllActions()
            camera.runAction(cameraAnimation)
        }
        
        // Put breakable tiles back.
        for y in 0 ..< level.tiles.count {
            for x in 0 ..< level.tiles[0].count {
                if (level.tiles[y][x] == 3) {
                    getNodeNamed("Tile\(x)_\(y)").isHidden = false
                    level.tiles[y][x] = 2
                }
            }
        }
    }
    
    internal func setPaused(_ paused: Bool) {
        scene.isPaused = paused
    }
    
    // Handles pan as default game control gesture.
    internal func handlePan(_ gestureRecognizer: UIGestureRecognizer) {
        // Don't handle pans just after player died.
        let threshold = Date(timeInterval: -0.2, since: Date())
        if lastDied.compare(threshold) == ComparisonResult.orderedDescending {
            return
        }
        
        let panGesture = gestureRecognizer as! UIPanGestureRecognizer
        let velocity = panGesture.velocity(in: gestureRecognizer.view)
        let xVelocity = velocity.x
        let yVelocity = velocity.y
        var direction:Direction = .north
        
        // If horizontal movement is bigger.
        if (abs(xVelocity) > abs(yVelocity)) {
            if (xVelocity > 0) {
                direction = .east
            } else {
                direction = .west
            }
        }
            
        // If vertical movement is bigger.
        else {
            if (yVelocity < 0) {
                direction = .north
            } else {
                direction = .south
            }
        }
        
        lastControl = Control(direction: direction, timestamp: Date())
        checkForMove()
    }
    
    // Perform move if not animating yet, move was played and move is possible.
    fileprivate func checkForMove() {
        if (level.blocky.isAnimating == false) {
            if let control = lastControl {
                let threshold = Date(timeInterval: -0.2, since: Date())
                if control.timestamp.compare(threshold) == ComparisonResult.orderedDescending {
                    if canMoveInDirection(control.direction) {
                        breakTileIfNeeded()
                        level.blocky.location = newLocation(level.blocky.location, direction: control.direction)
                        move(control.direction)
                    }
                }
            }
        }
    }
    
    // Checks if block can move in given direction, based on map.
    fileprivate func canMoveInDirection(_ direction: Direction) -> Bool {
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
    fileprivate func newLocation(_ currentLocation: (Int, Int), direction: Direction) -> (Int, Int) {
        let (oldX, oldY) = currentLocation
        switch(direction) {
        case Direction.north: return (oldX, oldY+1)
        case Direction.east: return (oldX+1, oldY)
        case Direction.south: return (oldX, oldY-1)
        case Direction.west: return (oldX-1, oldY)
        }
    }
    
    fileprivate func move(_ direction: Direction) {
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
                    return
                }
            }
            self.checkForMove()
        })
        
        // Animate camera if needed.
        if (level.cameraFollowsBlock) {
            let camera = getNodeNamed("Camera")
            let cameraAnimation = AnimationFactory.getDefaultMove(direction: direction, duration: 0.5)
            camera.runAction(cameraAnimation)
        }
    }
    
    // Makes tile invisble if old tile was breakable.
    fileprivate func breakTileIfNeeded() {
//        if (level.tiles[level.blocky.location.1][level.blocky.location.0] == 2) {
//            getNodeNamed("Tile\(level.blocky.location.0)_\(level.blocky.location.1)").isHidden = true
//            level.tiles[level.blocky.location.1][level.blocky.location.0] = 3
//        }
    }
    
    // Returns node with given name from currently loaded scene.
    fileprivate func getNodeNamed(_ name: String) -> SCNNode {
        return scene.rootNode.childNode(withName: name, recursively: false)!
    }
    
    // Returns default cube as physics body
    fileprivate func createBoxPhysicsBody(categoryBitMask: Int, collisionBitMask: Int, edge: CGFloat) -> SCNPhysicsBody {
        
        let blockBox = SCNBox(width: edge, height: edge, length: edge, chamferRadius: 0)
        let blockPhysicsShape = SCNPhysicsShape(geometry: blockBox, options: nil)
        
        let body = SCNPhysicsBody(type: SCNPhysicsBodyType.kinematic, shape: blockPhysicsShape)
        
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
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        // No collisions on start location: prevent bugs on resetting scene.
        if (level.blocky.location.0 != level.blocky.startLocation.0 ||
            level.blocky.location.1 != level.blocky.startLocation.1) {
            // If contact with Enemy.
            if (contact.nodeB.physicsBody?.categoryBitMask == enemyCategory) {
                die()
            }
            // If contact with Food.
            else if (contact.nodeB.physicsBody?.categoryBitMask == foodCategory) {
                contact.nodeB.isHidden = true
            }
        }
    }
    
    func win() {
        Database.wonLevel(level.levelNumber)
        won = true
        mainViewController.setMenuVisible(true)
    }
    
    func die() {
        lastDied = Date()
        reset()
    }
    
}
