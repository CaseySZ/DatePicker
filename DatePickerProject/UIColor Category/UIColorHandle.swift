//
//  UIColorHandle.swift
//  PersonReport
//
//  Created by Casey on 08/11/2018.
//  Copyright © 2018 Casey. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init (red: Int, green: Int, blue:Int, _ alpha:CGFloat = 1) {
        
        assert(red >= 0 && red <= 255, "Invalid red color")
        assert(green >= 0 && green <= 255, "Invalid green color")
        assert(blue >= 0 && blue <= 255, "Invalid blue color")
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    convenience init(rgb: Int){
        
        self.init(red: (rgb >> 16) & 0xff, green: (rgb >> 8) & 0xff, blue: rgb & 0xff)
        
    }
    
    
}

