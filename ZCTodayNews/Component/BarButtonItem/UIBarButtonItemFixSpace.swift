//
//  UIBarButtonItemFixSpace.swift
//  ZCTodayNews
//
//  Created by chaozhang on 2017/12/21.
//  Copyright © 2017年 ZZC. All rights reserved.
//

import Foundation
import UIKit


public var z_defultFixSpace:CGFloat = 0
public var z_disableFixSapce: Bool = false

extension UINavigationController {
    private struct AssociatedKeys {
        static var tempDisableFixSpace: Void?
        static var tempBehavor: Void?
    }
    
    
    
    static let u_initialize: Void = {
        
        DispatchQueue.once {
            
            swizzleMethod(UINavigationController.self, originalSelector:#selector(UINavigationController.viewDidLoad), swizzleSelector: #selector(UINavigationController.u_viewDidLoad))
            
            swizzleMethod(UINavigationController.self, originalSelector: #selector(UINavigationController.viewWillAppear(_:)), swizzleSelector: #selector(UINavigationController.u_viewWillAppear(_:)))
            
            swizzleMethod(UINavigationController.self,
                          originalSelector: #selector(UINavigationController.viewWillDisappear(_:)),
                          swizzleSelector: #selector(UINavigationController.u_viewWillDisappear(_:)))
            
        }
        
    }()
    
    
    
    private var tempDisableFixSpace: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tempDisableFixSpace) as? Bool ?? false
        }
        
        set {
         objc_setAssociatedObject(self, &AssociatedKeys.tempDisableFixSpace, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
    }
    
   @available(iOS 11.0, *)
    private var tempBehavor:UIScrollViewContentInsetAdjustmentBehavior {
    
            get {
              
                return objc_getAssociatedObject(self, &AssociatedKeys.tempBehavor) as? UIScrollViewContentInsetAdjustmentBehavior ?? .automatic
            }
    
            set {
               objc_setAssociatedObject(self, &AssociatedKeys.tempBehavor, newValue,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
    }
    
    
    @objc private func u_viewDidLoad() {
        disableFixSpace(true, with: true)
        u_viewDidLoad()
    }
    
    @objc private func u_viewWillAppear(_ animated: Bool) {
        
        disableFixSpace(true, with: true)
        u_viewWillAppear(animated)
        
    }
    
    @objc private func u_viewWillDisappear(_ animated: Bool) {
        disableFixSpace(false, with: true)
        u_viewWillDisappear(animated)
    }
    
    
    private func disableFixSpace(_ disable:Bool, with temp:Bool) {
        if self is UIImagePickerController {
            if disable {
                if temp {tempDisableFixSpace = z_disableFixSapce}
                z_disableFixSapce = true
                if #available(iOS 11.0, *) {
                    tempBehavor = UIScrollView.appearance().contentInsetAdjustmentBehavior
                    UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
                    
                    
                } else {
                    z_disableFixSapce = tempDisableFixSpace
                    if #available(iOS 11.0, *) {
                        UIScrollView.appearance().contentInsetAdjustmentBehavior = tempBehavor
                    }
                }
            }
        }
    }
    
}

@available (iOS 11.0 , *)

extension UINavigationBar {
    
    static let u_initialize: Void = {
        DispatchQueue.once {
            swizzleMethod(UINavigationBar.self, originalSelector: #selector(UINavigationBar.layoutSubviews), swizzleSelector: #selector(UINavigationBar.u_layoutSubviews))
        }
    }()
    
    
    @objc func u_layoutSubviews() {
        u_layoutSubviews()
        if !z_disableFixSapce {
            layoutMargins = .zero
            let space = z_defultFixSpace
            for view in subviews {
                if NSStringFromClass(view.classForCoder).contains("ContentView") {
                    view.layoutMargins = UIEdgeInsetsMake(0, space, 0, space)
                }
            }
            
        }
        
    }
    
}



