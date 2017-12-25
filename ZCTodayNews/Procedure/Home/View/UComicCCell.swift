//
//  UComicCCell.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/12/25.
//  Copyright © 2017年 ZZC. All rights reserved.
//

import UIKit

enum UComicCCellStyle {
    case none
    case withTitle
    case withTitleAndDesc
}


class UComicCCell: UBaseCollectionViewCell {
    
    private lazy var iconView: UIImageView  = {
        
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        iw.clipsToBounds = true
        return iw
        
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let t1 = UILabel()
        t1.textColor = UIColor.black
        t1.font = UIFont.systemFont(ofSize: 14)
        return t1
    }()
    
    
    private lazy var descLabel: UILabel = {
        let dl = UILabel()
        dl.textColor = UIColor.gray
        dl.font = .systemFont(ofSize: 12)
        return dl
    }()
    
    
    var style: UComicCCellStyle = .withTitle {
        didSet {
            switch style {
            case .none:
                titleLabel.snp.updateConstraints{
                $0.bottom.equalToSuperview().offset(25)
                }
                titleLabel.isHidden = true
                descLabel.isHidden = true
                
            case .withTitle:
                titleLabel.snp.updateConstraints{
                    $0.bottom.equalToSuperview().offset(-10)
                }
                titleLabel.isHidden = false
                descLabel.isHidden = true
            
            case .withTitleAndDesc:
                titleLabel.snp.updateConstraints{
                    $0.bottom.equalToSuperview().offset(-25)
                }
                titleLabel.isHidden = false
                descLabel.isHidden = false
            }
        }
    }
    
    override func configUI() {
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(UIEdgeInsetsMake(0, 10, 0, 10))
            $0.height.equalTo(25)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top)
        }
        
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(UIEdgeInsetsMake(0, 10, 0, 10))
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
    }
    
    var model: ComicModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.cover, placeholder: (bounds.width > bounds.height) ? UIImage(named: "normal_placeholder_h"): UIImage(named: "normal_placeholder_v"))
            titleLabel.text = model.name ?? model.title
            descLabel.text = model.subTitle ?? "更新至\(model.content ?? "0")集"
        }
        
        
    }
    
    
}
