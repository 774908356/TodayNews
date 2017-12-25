//
//  UBaseCollectionViewCell.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/12/25.
//  Copyright © 2017年 ZZC. All rights reserved.
//

import UIKit
import Reusable

class UBaseCollectionViewCell: UICollectionViewCell, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI(){}
}
