//
//  UIView+Extension.swift
//  ThoughtCtlTask
//
//  Created by Apple on 01/01/24.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func cornerRadius(cornerRadius: CGFloat = 5) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func circularView(isBorderless: Bool = true, color: UIColor = UIColor.white.withAlphaComponent(0.9), borderWidth: CGFloat = 1.5) {
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
        if isBorderless {
            layer.borderWidth = borderWidth
            layer.borderColor = color.cgColor
        }
    }
}

