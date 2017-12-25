//
//  UBoutiqueListViewController.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/12/22.
//  Copyright © 2017年 ZZC. All rights reserved.

import UIKit
import LLCycleScrollView

class UBoutiqueListViewController: UBaseViewController {

    private var sexType: Int = UserDefaults.standard.integer(forKey: String.sexTypeKey)
    private var galleryItems = [GalleryItemModel]()
    private var TextItems = [TextItemModel]()
    private var comicLists = [ComicListModel]()
    
    
    private lazy var bannerView:LLCycleScrollView = {
        let bw = LLCycleScrollView()
        bw.backgroundColor = UIColor.background
        bw.autoScrollTimeInterval = 5
        bw.placeHolderImage = UIImage(named: "normal_placeholder")
        bw.coverImage = UIImage()
        bw.pageControlPosition = .right
        bw.pageControlBottom = 20
        bw.titleBackgroundColor = UIColor.clear
//        bw.lldidSelectItemAtIndex = 
        
        return bw
        
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let lt = UCollectionViewSectionBackgroundLayout()
        lt.minimumInteritemSpacing = 5
        lt.minimumLineSpacing = 10
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        
        cw.backgroundColor = UIColor.background
        cw.delegate = self
       // cw.dataSource = self
        cw.alwaysBounceVertical = true
        
        
        return cw
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(false)
        // Do any additional setup after loading the view.
    }

    private func loadData(_ changeSex: Bool) {
        if changeSex {
            sexType = 3 - sexType
            UserDefaults.standard.set(sexType, forKey: String.sexTypeKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: .USexTypeDidChange, object: nil)
        }
        
        ApiLoadingProvider.request(ZCApi.boutiqueList(sexType: sexType), model: BoutiqueListModel.self) { [weak self] (returnData) in
            self?.galleryItems = returnData?.galleryItems ?? []
            self?.TextItems = returnData?.textItems ?? []
            self?.comicLists = returnData?.comicLists ?? []
            self?.bannerView.imagePaths = self?.galleryItems.map{ $0.cover! } ?? []
            
        }
        
        
        
        
    }
    
    override func configUI() {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalToSuperview()
            
        }
        
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(collectionView.contentInset.top)

        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UBoutiqueListViewController: UCollectionViewSectionBackgroundLayoutDelegateLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            bannerView.snp.updateConstraints{
                $0.top.equalToSuperview().offset(min(0, -(scrollView.contentOffset.y + scrollView.contentInset.top)))
            }
        }
    }
    
}

