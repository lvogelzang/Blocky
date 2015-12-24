//
//  MenuViewController.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 24-12-15.
//  Copyright © 2015 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var levelCollectionView: UICollectionView!
    
    var mainViewController: MainViewController? = nil
    
    // MARK: - Initializing
    
    override func viewDidLoad() {
        
        self.initCollectionView()
        
        super.viewDidLoad()

    }
    
    // Initialize collection view containing levels.
    private func initCollectionView() {
        
        levelCollectionView.dataSource = self
        levelCollectionView.delegate = self
        
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
    
    // Hide menu view on clicking play button.
    @IBAction func play(sender: AnyObject) {
        
        mainViewController?.toggleMenu()
        
    }
    
    // Load level after selecting a level from collection view.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        mainViewController?.loadLevel(indexPath.item)
        
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
