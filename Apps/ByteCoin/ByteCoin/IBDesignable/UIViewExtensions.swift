//
//  UIViewExtensions.swift
//  ByteCoin
//
//  Created by Александр on 24.02.2021.
//

import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var isHBordersRounded: Bool {
        set {
            if newValue {
                layer.cornerRadius = self.frame.height / 2
            }
        }
        
        get {
            var isHRounded: Bool
            
            if layer.cornerRadius == self.frame.height / 2 {
                isHRounded = true
            } else {
                isHRounded = false
            }
            
            return isHRounded
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        set {
            layer.shadowColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: layer.shadowColor ?? UIColor.clear.cgColor)
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        
        get {
            return layer.shadowOffset
        }
    }
}
