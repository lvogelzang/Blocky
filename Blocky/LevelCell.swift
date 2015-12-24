//
//  LevelCellViewCollectionViewCell.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 18-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit
import QuartzCore

class LevelCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setBackgroundView()
        setSelectedBackgroundView()
        addLabel()
        
    }
    
    func setBackgroundView() {
        
        let localFrame = CGRectMake(10, 10, frame.size.width-20, frame.size.height-20)
        
        // Create circle shape.
        let circleView = UIView(frame: localFrame)
        circleView.backgroundColor = UIColor(white: 1, alpha: 1)
        circleView.layer.cornerRadius = 40 / 2
        
        // Add shadows.
        circleView.layer.shadowColor = UIColor(white: 0, alpha: 1).CGColor;
        circleView.layer.shadowOpacity = 0.1;
        circleView.layer.shadowRadius = 2;
        circleView.layer.shadowOffset = CGSize(width: 0, height: 2);
        
        self.backgroundView = UIView()
        self.backgroundView?.addSubview(circleView)
        
    }
    
    func setSelectedBackgroundView() {
        
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView!.backgroundColor = UIColor.whiteColor()
        
        let localFrame = CGRectMake(10, 10, frame.size.width-20, frame.size.height-20)
        
        // Create circle shape.
        let circleView = UIView(frame: localFrame)
        circleView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        circleView.layer.cornerRadius = 40 / 2
        
        self.selectedBackgroundView!.addSubview(circleView)
    }
    
    func addLabel() {
        
        let labelFrame = CGRectMake(0, 9, frame.size.width, frame.size.height-9)
        label.frame = labelFrame
        
        label.font = UIFont(name: "Damascus", size: 14)
        label.textColor = UIColor(white: 0.6, alpha: 1)
        label.textAlignment = NSTextAlignment.Center
        
        contentView.addSubview(label)
        
    }
    
    // Required to implement, but never used.
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    
    }
    
}
