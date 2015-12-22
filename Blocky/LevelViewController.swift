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

class LevelViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var tempSceneView: SCNView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var levelCollectionView: UICollectionView!
    
    weak var sceneController: SceneController?
    
    override func viewDidLoad() {
        
        loadLevel(0)
        
        levelCollectionView.registerClass(LevelCell.self, forCellWithReuseIdentifier: "levelCell")
        levelCollectionView.registerClass(LevelPackHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "levelPackHeaderView")
        levelCollectionView.registerClass(LevelPackHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "levelPackHeaderView")
        levelCollectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        levelCollectionView.selectItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.CenteredVertically)
        
        let layout = UICollectionViewFlowLayout()
        //layout.headerReferenceSize = CGSizeMake(0, 65)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.itemSize = CGSizeMake(60, 60)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        levelCollectionView.collectionViewLayout = layout
        
        super.viewDidLoad()
        
        sceneView.antialiasingMode = SCNAntialiasingMode.Multisampling4X
        tempSceneView.antialiasingMode = SCNAntialiasingMode.Multisampling4X
        
        menuView.hidden = true
        
    }
    
    // Initialize level, called before showing the level view
    func loadLevel(level: Int) {
        
        // Swap sceneView with tempSceneView
        let temp = tempSceneView
        tempSceneView = sceneView
        sceneView = temp
        view.bringSubviewToFront(sceneView)
        view.bringSubviewToFront(menuView)
        
        // Hide first scene view
        sceneView.alpha = 0
        
        // Set new scene to first scene first
        sceneController?.unload()
        sceneController = SceneFactory.createScene(self, level: level)
        sceneView.scene = sceneController!.scene
        sceneView.scene?.paused = true
        
        // Fade in new scene, remove old scene after fading in
        UIView.animateWithDuration(0.25,
            animations: { self.sceneView.alpha = 1 },
            completion: { (completed: Bool) in self.tempSceneView.scene = nil }
        )
        
        // Add gesture recognizers
        let panGestureRecognizer = UIPanGestureRecognizer(target: sceneController!.blocky!, action: "handlePan:")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        
        sceneView.gestureRecognizers = [panGestureRecognizer, tapGestureRecognizer]
        
    }
    
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        loadLevel(indexPath.item)
        
    }
    
/*    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "levelPackHeaderView", forIndexPath: indexPath) as! LevelPackHeaderView
        
        header.label.text = "Levels:"
        
        return header
        
    }*/
    
    @IBAction func play(sender: AnyObject) {
        
        toggleMenu()
        
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        // Handle taps only if not died
        if (sceneController!.blocky!.died != true) {
            
            toggleMenu()
            
        }
        
    }
    
    func toggleMenu() {
        
        if (menuView.hidden == true) {
            
            // Show menu
            let showMenuCodeBlock = {self.menuView.hidden = false}
            NSOperationQueue.mainQueue().addOperationWithBlock(showMenuCodeBlock)
            sceneView.scene?.paused = true
            
        } else {
            
            // Hide menu
            let hideMenuCodeBlock = {self.menuView.hidden = true}
            NSOperationQueue.mainQueue().addOperationWithBlock(hideMenuCodeBlock)
            sceneView.scene?.paused = false
            
        }
        
    }
    
}
