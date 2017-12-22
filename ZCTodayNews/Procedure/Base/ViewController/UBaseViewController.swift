//
//  UBaseViewController.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/12/22.
//  Copyright © 2017年 ZZC. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Reusable
import Kingfisher



class UBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.background
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }else {
            automaticallyAdjustsScrollViewInsets = false
        }
        configUI()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func configUI(){}

    func configNavigationBar() {
        guard let navi = navigationController else {
            return
        }
        
        if navi.visibleViewController == self {
            navi.barStyle(.theme)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_white"), style: .plain, target: self, action: #selector(pressBack))
            }
        }
      
        
    }
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
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
