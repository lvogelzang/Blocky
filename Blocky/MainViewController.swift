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

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var scenesContainerView: UIView!
    @IBOutlet var sceneView: SCNView!
    @IBOutlet var tempSceneView: SCNView!
    
    var sceneController: SceneController?
    
    @IBOutlet weak var levelCollectionView: UICollectionView!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var triesLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var star1ImageView: UIImageView!
    @IBOutlet weak var star2ImageView: UIImageView!
    @IBOutlet weak var star3ImageView: UIImageView!
    
    // MARK: - Initializing
    
    override func viewDidLoad() {
        
        // Add gesture recognizers to scenes container view.
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.scenesContainerView.gestureRecognizers = [panGestureRecognizer, tapGestureRecognizer]
        
        loadLevel(0)
        
        super.viewDidLoad()
        
        sceneView.antialiasingMode = SCNAntialiasingMode.Multisampling4X
        tempSceneView.antialiasingMode = SCNAntialiasingMode.Multisampling4X
        
        self.initCollectionView()
        
    }
    
    // Initialize collection view containing levels.
    private func initCollectionView() {
        
        // Set cells.
        levelCollectionView.registerClass(LevelCell.self, forCellWithReuseIdentifier: "levelCell")
        levelCollectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        levelCollectionView.selectItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.CenteredVertically)
        
        // Set layout.
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.itemSize = CGSizeMake(60, 60)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        levelCollectionView.collectionViewLayout = layout
        
    }
    
    // MARK: - User interaction
    
    // Toggle menu visibility on a tap.
    internal func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        setMenuHidden(!menuView.hidden)
        
    }
    
    // Hide or unhide menu.
    internal func setMenuHidden(menuHidden: Bool) {
        
        sceneView.scene?.paused = !menuHidden
        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.menuView.hidden = menuHidden
            if (menuHidden == false) {
                self.updateValues()
            }
        })
        
    }
    
    // Catch and pass pan gestures as game controls.
    internal func handlePan(gestureRecognizer: UIGestureRecognizer) {
        
        if (menuView.hidden) {
            sceneController?.handlePan(gestureRecognizer)
        }
        
    }
    
    // Initialize level, called before showing the level view.
    internal func loadLevel(level: Int) {
        
        // Swap sceneView with tempSceneView.
        let temp = tempSceneView
        tempSceneView = sceneView // Move current scene to back.
        sceneView = temp // Move new scene to front.
        scenesContainerView.bringSubviewToFront(sceneView)
        
        // Hide first scene view.
        sceneView.alpha = 0
        
        // Set new scene controller.
        sceneController = SceneFactory.createScene(self, levelNumber: level)
        sceneView.scene = sceneController?.scene
        
        // Fade in new scene, remove old scene after fading in.
        UIView.animateWithDuration(0.25,
            animations: { self.sceneView.alpha = 1 },
            completion: { (completed: Bool) in self.tempSceneView.scene = nil }
        )
        
    }
    
    // Hide menu view on clicking play button.
    @IBAction func play(sender: AnyObject) {
        
        setMenuHidden(true)
        
    }
    
    // Load level after selecting a level from collection view.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        loadLevel(indexPath.item)
        updateValues()
        
    }
    
    internal func updateValues() {
        
        let levelNumber = sceneController!.level.levelNumber
        
        let best = Database.getBestForLevel(levelNumber)
        bestLabel.text = "Best: \(best)"
        
        let tries = Database.getTriesForLevel(levelNumber)
        triesLabel.text = "Tries: \(tries)"
        
        star1ImageView.image = UIImage(named: "Star")
        star2ImageView.image = UIImage(named: "Star")
        star3ImageView.image = UIImage(named: "Star")
        if (best < 999) {
            star1ImageView.image = UIImage(named: "Star_filled")
        }
        if (best < 5) {
            star2ImageView.image = UIImage(named: "Star_filled")
        }
        if (best == 1) {
            star3ImageView.image = UIImage(named: "Star_filled")
        }
        
    }
    
    // MARK: - Collection view datasource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return SceneFactory.getNumberOfLevels()
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("levelCell", forIndexPath: indexPath) as! LevelCell
        
        cell.label.text = "\(indexPath.item + 1)"
        
        return cell
        
    }
    
}
