//
//  MainViewController.swift
//  Blocky
//
//  Created by Lodewijck on 11/08/2018.
//  Copyright © 2018 Lodewijck. All rights reserved.
//

import UIKit
import SceneKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var scenesContainerView: UIView!
    @IBOutlet var sceneView: SCNView!
    @IBOutlet var tempSceneView: SCNView!
    
    var sceneController: SceneController?
    
    @IBOutlet var levelCollectionView: UICollectionView!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var triesLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var star1ImageView: UIImageView!
    @IBOutlet weak var star2ImageView: UIImageView!
    @IBOutlet weak var star3ImageView: UIImageView!
    
    // MARK: - Initializing
    
    override func viewDidLoad() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.handlePan(_:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.handleTap(_:)))
        self.scenesContainerView.gestureRecognizers = [panGestureRecognizer, tapGestureRecognizer]
        
        loadLevel(0)
        
        super.viewDidLoad()
        
        sceneView.antialiasingMode = SCNAntialiasingMode.multisampling4X
        tempSceneView.antialiasingMode = SCNAntialiasingMode.multisampling4X
        
        self.initCollectionView()
    }
    
    // Initialize collection view containing levels.
    fileprivate func initCollectionView() {
        // Set cells.
        levelCollectionView.register(LevelCell.self, forCellWithReuseIdentifier: "levelCell")
        levelCollectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        levelCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
        
        // Set layout.
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        levelCollectionView.collectionViewLayout = layout
        
        updateValues()
    }
    
    // MARK: - User interaction
    
    // Toggle menu visibility on a tap.
    @objc internal func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        setMenuHidden(!menuView.isHidden)
    }
    
    // Hide or unhide menu.
    internal func setMenuHidden(_ menuHidden: Bool) {
        sceneView.scene?.isPaused = !menuHidden
        OperationQueue.main.addOperation({
            self.menuView.isHidden = menuHidden
            if (menuHidden == false) {
                self.updateValues()
                self.levelCollectionView.reloadData()
            }
        })
    }
    
    // Catch and pass pan gestures as game controls.
    @objc internal func handlePan(_ gestureRecognizer: UIGestureRecognizer) {
        if (menuView.isHidden) {
            sceneController?.handlePan(gestureRecognizer)
        }
    }
    
    // Initialize level, called before showing the level view.
    internal func loadLevel(_ level: Int) {
        // Swap sceneView with tempSceneView.
        let temp = tempSceneView
        tempSceneView = sceneView // Move current scene to back.
        sceneView = temp // Move new scene to front.
        scenesContainerView.bringSubview(toFront: sceneView)
        
        // Hide first scene view.
        sceneView.alpha = 0
        
        // Set new scene controller.
        sceneController = SceneFactory.createScene(self, levelNumber: level)
        sceneView.scene = sceneController?.scene
        
        // Fade in new scene, remove old scene after fading in.
        UIView.animate(withDuration: 0.25,
                       animations: { self.sceneView.alpha = 1 },
                       completion: { (completed: Bool) in self.tempSceneView.scene = nil }
        )
    }
    
    // Hide menu view on clicking play button.
    @IBAction func play(_ sender: AnyObject) {
        setMenuHidden(true)
    }
    
    // Disable locked levels.
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if cellIsDisabled((indexPath as NSIndexPath).item) {
            let index = collectionView.indexPathsForSelectedItems![0]
            collectionView.selectItem(at: index, animated: false, scrollPosition: UICollectionViewScrollPosition())
            return false
        } else {
            return true
        }
    }
    
    fileprivate func cellIsDisabled(_ cellNumber: Int) -> Bool {
        if cellNumber == 0 {
            return false
        } else {
            let prevLevel = SceneFactory.sceneForLevel(cellNumber - 1)
            if Database.getBestForLevel(prevLevel) < 999 {
                return false
            } else {
                return true
            }
        }
    }
    
    // Load level after selecting a level from collection view.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        loadLevel((indexPath as NSIndexPath).item)
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
            star1ImageView.image = UIImage(named: "StarFilled")
        }
        if (best < 5) {
            star2ImageView.image = UIImage(named: "StarFilled")
        }
        if (best == 1) {
            star3ImageView.image = UIImage(named: "StarFilled")
        }
    }
    
    // MARK: - Collection view datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SceneFactory.getNumberOfLevels()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "levelCell", for: indexPath) as! LevelCell
        
        cell.label.text = "\((indexPath as NSIndexPath).item + 1)"
        
        if cellIsDisabled((indexPath as NSIndexPath).item) {
            cell.label.textColor = UIColor(white: 0.9, alpha: 1)
        } else {
            cell.label.textColor = UIColor(white: 0.6, alpha: 1)
        }
        
        return cell
    }
    
}
