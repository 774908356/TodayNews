//
//  UCollectionViewAlignedLayout.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/12/23.
//  Copyright © 2017年 ZZC. All rights reserved.
//

import UIKit

protocol Aligment {}

public enum HorizontalAlignment: Aligment {
    case left
    case justified
    case right
}

public enum VerticalAlignment: Aligment {
    
    case top
    case center
    case bottom
}

private struct AligmentAxis<A: Aligment> {
    
    let aligment: A
    let position: CGFloat

}


class UCollectionViewAlignedLayout: UICollectionViewFlowLayout {

    public var horizontalAligment: HorizontalAlignment = .justified
    
    public var verticalAligment: VerticalAlignment = .center
    
    
    
}
