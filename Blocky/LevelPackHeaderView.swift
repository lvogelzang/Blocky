//
//  levelPackHeaderView.swift
//  Blocky
//
//  Created by Lodewijck Vogelzang on 19-08-14.
//  Copyright (c) 2014 Lodewijck Vogelzang. All rights reserved.
//

import UIKit

class LevelPackHeaderView: UICollectionReusableView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        
        let localFrame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        label.frame = localFrame
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
        label.textColor = UIColor.darkGrayColor()
        label.textAlignment = NSTextAlignment.Center
        
        super.init(frame: frame)
        
        addSubview(label)
        
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }
    
}
