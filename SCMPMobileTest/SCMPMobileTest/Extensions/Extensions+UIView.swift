//
//  Extensions+UIView.swift
//  SCMPMobileTest
//
//  Created by 李宗政 on 12/9/23.
//

import UIKit

extension UIView {
    //設定layout 對齊某一邊 leading、trailing、top、bottom
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    //水平置中
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor?, paddingTop: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor,
           let padding = paddingTop {
            self.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        }
    }
    //垂直置中
    func centerY(inView view: UIView, leftAnochor: NSLayoutXAxisAnchor?, paddingLeft: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if let leftAnochor = leftAnochor,
           let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnochor, constant: padding).isActive = true
        }
    }
    //設定元件大小
    func setDimensions(height: CGFloat, width: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant:height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    //設定寬高
    func setHeight(height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    //全螢幕
    func fillSuperview() {
        
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
              let superviewBottomAnchor = superview?.bottomAnchor,
              let superviewLeftAnchor = superview?.leftAnchor,
              let superviewRightAnchor = superview?.rightAnchor else {
            return
        }
        
        anchor(top: superviewTopAnchor, left: superviewLeftAnchor,
               bottom: superviewBottomAnchor, right: superviewRightAnchor)
    }
}
