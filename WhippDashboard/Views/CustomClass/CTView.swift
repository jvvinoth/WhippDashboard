//
//  CTView.swift
//  Zouba
//
//  Created by Vinoth Varatharajan on 02/07/19.
//  Copyright © 2019 Vin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CTView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var showBorder: Bool = false {
        didSet {
            if self.showBorder {
                self.addBorder()
            }
            else {
                self.removeBorder()
            }
        }
    }
    
    @IBInspectable var borderColor: UIColor = .blue {
        didSet {
            if shadowLayer != nil {
                shadowLayer.strokeColor = borderColor.cgColor
            }
        }
    }
    
    @IBInspectable var applyTintColorToInnerElements: Bool = false {
        didSet {
            for view in self.subviews {
                view.tintColor = borderColor
            }
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateView()
    }
    
    private func updateView() {
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3
            layer.insertSublayer(shadowLayer, at: 0)
        }
        
        if shadowLayer != nil {
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        }
    }
    
    private func addBorder() {
        
        if shadowLayer != nil {
            shadowLayer.strokeColor = borderColor.cgColor
        }
    }
    
    private func removeBorder() {
        
        if shadowLayer != nil {
            shadowLayer.strokeColor = UIColor.clear.cgColor
        }
    }
}

class CTBorderView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            //updateView()
        }
    }
    
    @IBInspectable var showShadow: Bool = false {
        didSet {
            if showShadow {
                showShadowLayer()
            }
            else {
                removeShadowLayer()
            }
        }
    }
    
    @IBInspectable var showBorder: Bool = true {
        didSet {
            
            if showBorder {
                showBorderLayer()
            }
            else {
                removeBorderLayer()
            }
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        
        if showShadow {
            showShadowLayer()
        }
        else {
            removeShadowLayer()
        }
    }
    
    func showBorderLayer() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    func removeBorderLayer() {
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.withAlphaComponent(0.5).cgColor
    }
    
    func showShadowLayer() {
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            layer.insertSublayer(shadowLayer, at: 0)
        }
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
    }
    
    func removeShadowLayer() {
        
        if shadowLayer != nil {
            shadowLayer.shadowOpacity = 0.0
            shadowLayer.shadowRadius = 0
        }
    }
}

class CTBorderPaymentView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            //updateView()
        }
    }
    
    @IBInspectable var showShadow: Bool = false {
        didSet {
            if showShadow {
                showShadowLayer()
            }
            else {
                removeShadowLayer()
            }
        }
    }
    
    @IBInspectable var showBorder: Bool = true {
        didSet {
            if showBorder {
                showBorderLayer()
            }
            else {
                removeBorderLayer()
            }
        }
    }
    
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        
        if showShadow {
            showShadowLayer()
        }
        else {
            removeShadowLayer()
        }
    }
    
    func showBorderLayer() {
        shadowLayer.strokeColor = UIColor.ctBlue.cgColor
        shadowLayer.lineWidth = 2
    }
    
    func removeBorderLayer() {
        shadowLayer.strokeColor = UIColor.clear.cgColor
        shadowLayer.lineWidth = 0
    }
    
    func showShadowLayer() {
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            layer.insertSublayer(shadowLayer, at: 0)
        }
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
    }
    
    func removeShadowLayer() {
        
        if shadowLayer != nil {
            shadowLayer.shadowOpacity = 0.0
            shadowLayer.shadowRadius = 0
            shadowLayer.fillColor = UIColor.ctBorderGray.cgColor
        }
    }
}
