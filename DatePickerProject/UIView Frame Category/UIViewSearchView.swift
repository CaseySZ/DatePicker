//
//  UIViewSearchView.swift
//  PersonReport
//
//  Created by Casey on 09/11/2018.
//  Copyright © 2018 Casey. All rights reserved.
//

import UIKit

extension UIView {
    
    
    // 查找className相关的subview
    func searchSubViewOfClassName(_ className:String) -> UIView? {
        
        let subviewArr:[UIView] = self.subviews.reversed()
        var targetView:UIView?
        
        for view in subviewArr {
            
            
            if NSStringFromClass(view.classForCoder).elementsEqual(className){
                
                targetView = view
                break
            }
            
        }
        return targetView
    }
    
    // 查找className相关的superview
    func searchSuperViewOfClassName(_ className:String) -> UIView? {
        
        
        let selfClassName = NSStringFromClass(type(of: self)) as NSString
        if selfClassName.isEqual(to: className){
            return self
        }
        
        if let superView =  self.superview {
            return superView.searchSuperViewOfClassName(className)
        }else {
            return nil
        }
        
    }
    
}
