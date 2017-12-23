//
//  UTabBarController.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/12/22.
//  Copyright © 2017年 ZZC. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        
        ///首页
        let onePageVC = UHomeViewController(titles: ["推荐",
                                                     "VIP",
                                                     "订阅",
                                                     "排行"],
                                            vcs: [UBoutiqueListViewController(),
                                                  UVIPListViewController(),
                                                  USubscibeListViewController(),
                                                  URankListViewController()],
                                            pageStyle: .navigationBarSegment)
        addChildViewController(onePageVC, title: "首页", image: UIImage(named:"tab_home"), selectedImage: UIImage(named: "tab_home_S"))
        
        
        let classVC = UCateListViewController()
        addChildViewController(classVC, title: "分类", image: UIImage(named: "tab_class"), selectedImage: UIImage(named: "tab_class_S"))
        
        let bookVC = UBookViewController()
        
        addChildViewController(bookVC, title: "书架", image: UIImage(named: "tab_book"), selectedImage: UIImage(named: "tab_book_S"))
        
        let mineVC = UMineViewController()
        addChildViewController(mineVC, title: "我的", image: UIImage(named: "tab_mine"), selectedImage: UIImage(named: "tab_mine_S"))
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        addChildViewController(UNavigationController(rootViewController: childController))
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

extension UTabBarController {
    
    override var preferredStatusBarStyle:UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
    
}

