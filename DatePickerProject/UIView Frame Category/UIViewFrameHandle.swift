//
//  UIViewFrameHandle.swift
//  PersonReport
//
//  Created by Casey on 08/11/2018.
//  Copyright © 2018 Casey. All rights reserved.
//

import UIKit

extension UIView {
    
    
    
    var x: CGFloat {
        
        get {
            
            return self.frame.origin.x
        }set {
            
            self.statusCenternX = false
            self.statusRight = false
            self.frame = CGRect.init(x: newValue, y: self.y, width: self.width, height: self.heigth)
        }
        
        
    }
    
    
    var y: CGFloat {
        
        get {
            
            return self.frame.origin.y
        }set {
            
            self.statusCenternY = false
            self.statusBottom = false
            self.frame = CGRect.init(x: self.x, y: newValue, width: self.width, height: self.heigth)
        }
        
    }
  
    var width: CGFloat {
        
        get {
            
            return self.frame.size.width
            
        }set {
            
            if self.statusCenternX {
                
                let centerX = self.centerX
                self.frame = CGRect.init(x: centerX-newValue/2, y: self.y, width: newValue, height: self.heigth)
                
            } else if self.statusRight {
                
                let right = self.right
                self.frame = CGRect.init(x: right-newValue, y: self.y, width: newValue, height: self.heigth)
                
            }else {

                self.frame = CGRect.init(x: self.x, y: self.y, width: newValue, height: self.heigth)
            }
            cleanStatusHorizontal()
        }
        
    }
    
    
    var heigth: CGFloat {
        
        get {
            
            return self.frame.size.height
            
        }set {
            
            if self.statusCenternY {
                
                let centerY = self.centerY
                self.frame = CGRect.init(x: self.x, y: centerY-newValue/2, width: self.width, height: newValue)
                
            }else if self.statusBottom{
                
                let bottom = self.bottom
                self.frame = CGRect.init(x: self.x, y: bottom-newValue, width: self.width, height: newValue)
                
            } else {
                
                self.frame = CGRect.init(x: self.x, y: self.y, width: self.width, height: newValue)
            }
            
            cleanStatusVertical()
        }
        
    }
    var centerX:  CGFloat {
        
        get {
            
            return self.x + self.width/2
        }
        
        set{
            
            cleanStatusHorizontal()
            self.statusCenternX = true
            self.frame = CGRect.init(x:newValue - self.width/2, y: self.y, width: self.width, height: self.heigth)
            
        }
        
    }
    
    var centerY:  CGFloat {
        
        get {
            
            return self.y + self.heigth/2
        }
        
        set{
            
            cleanStatusVertical()
            self.statusCenternY = true
            self.frame = CGRect.init(x:self.x, y: newValue - self.heigth/2, width: self.width, height: self.heigth)
            
        }
        
    }
    
    var left:  CGFloat {
        
        get {
            
            return self.x
        }
        
        set{
            
            cleanStatusHorizontal()
            self.statusLeft = true
            if self.statusRight {
                self.frame = CGRect.init(x:newValue, y: self.y, width: self.right - newValue, height: self.heigth)
            }else {
                self.frame = CGRect.init(x:newValue, y: self.y, width: self.width, height: self.heigth)
            }
        }
        
    }
    
    var right:  CGFloat {
        
        get {
            
            return self.x + self.width
        }
        
        set{
            
            cleanStatusHorizontal()
            self.statusRight = true
            if self.statusLeft {
                self.frame = CGRect.init(x:self.left, y: self.y, width: newValue - self.left, height: self.heigth)
            }else {
                self.frame = CGRect.init(x:newValue-self.width, y: self.y, width: self.width, height: self.heigth)
            }
        }
        
    }

    var top:  CGFloat {
        
        get {
            
            return self.y
        }
        
        set{
            
            cleanStatusVertical()
            self.statusTop = true
            
            if self.statusBottom {
                self.frame = CGRect.init(x:self.x, y: newValue, width: self.width, height: self.bottom - newValue)
            }else{
                self.frame = CGRect.init(x:self.x, y: newValue, width: self.width, height: self.heigth)
            }
            
        }
        
    }
    
    var bottom:  CGFloat {
        
        get {
            
            return self.y + self.heigth
        }
        
        set{
            
            cleanStatusVertical()
            self.statusBottom = true
            if self.statusTop {
                
                self.frame = CGRect.init(x:self.x, y: self.top, width: self.width, height: newValue - self.top)
                
            }else {
                
                self.frame = CGRect.init(x:self.x, y: newValue - self.heigth, width: self.width, height: self.heigth)
            }
        }
        
    }
    
    
    func cleanFrameStatus()  {
        
        cleanStatusHorizontal()
        cleanStatusVertical()
    }
}


fileprivate extension UIView {

    
    func cleanStatusVertical()  {
        self.statusCenternY = false
        self.statusTop = false
        self.statusBottom = false
    }
    
    func cleanStatusHorizontal()  {
        self.statusCenternX = false
        self.statusLeft = false
        self.statusRight = false
    }
    
    var statusCenternX: Bool {
        
        
        get{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusCenternX".hashValue)
            
            let number =  objc_getAssociatedObject(self, key) as? NSNumber
            
            return number?.boolValue ?? false
            
        }set{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusCenternX".hashValue)
            let number = NSNumber.init(value: newValue)
            objc_setAssociatedObject(self, key, number, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    
    var statusCenternY: Bool {
        
        
        get{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusCenternY".hashValue)
            
            let number =  objc_getAssociatedObject(self, key) as? NSNumber
            
            return number?.boolValue ?? false
            
        }set{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusCenternY".hashValue)
            let number = NSNumber.init(value: newValue)
            objc_setAssociatedObject(self, key, number, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    
    var statusTop: Bool {
        
        
        get{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusTop".hashValue)
            
            let number =  objc_getAssociatedObject(self, key) as? NSNumber
            
            return number?.boolValue ?? false
            
        }set{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusTop".hashValue)
            let number = NSNumber.init(value: newValue)
            objc_setAssociatedObject(self, key, number, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    
    var statusBottom: Bool {
        
        
        get{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusBottom".hashValue)
            
            let number =  objc_getAssociatedObject(self, key) as? NSNumber
            
            return number?.boolValue ?? false
            
        }set{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusBottom".hashValue)
            let number = NSNumber.init(value: newValue)
            objc_setAssociatedObject(self, key, number, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    
    var statusLeft: Bool {
        
        
        get{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusLeft".hashValue)
            
            let number =  objc_getAssociatedObject(self, key) as? NSNumber
            
            return number?.boolValue ?? false
            
        }set{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusLeft".hashValue)
            let number = NSNumber.init(value: newValue)
            objc_setAssociatedObject(self, key, number, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    
    var statusRight: Bool {
        
        
        get{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusRight".hashValue)
            
            let number =  objc_getAssociatedObject(self, key) as? NSNumber
            
            return number?.boolValue ?? false
            
        }set{
            
            let key:UnsafePointer<String>! = UnsafePointer.init(bitPattern: "_statusRight".hashValue)
            let number = NSNumber.init(value: newValue)
            objc_setAssociatedObject(self, key, number, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    
}
