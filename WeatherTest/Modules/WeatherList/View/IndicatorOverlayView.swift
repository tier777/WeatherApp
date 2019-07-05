//
//  IndicatorOverlayView.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

protocol IndicatorOverlayViewProtocol: AnyObject {
    
    static func show(for viewController: UIViewController)
    static func dismiss(for viewController: UIViewController)
}

class IndicatorOverlayView: UIView {
    
    private let indicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupIndicator()
    }
    
    private func setupIndicator() {
        
        if indicator.superview == nil {
            
            addSubview(indicator)
            indicator.center = center
            indicator.startAnimating()
        }
    }
}

extension IndicatorOverlayView: IndicatorOverlayViewProtocol {
    
    static func show(for viewController: UIViewController) {
        
        guard let window = viewController.view.window else { return }
        
        let overlay = IndicatorOverlayView(frame: window.bounds)
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        overlay.alpha = 0
        
        window.addSubview(overlay)
        
        UIView.animate(withDuration: 0.3) {
            
            overlay.alpha = 1
        }
    }
    
    static func dismiss(for viewController: UIViewController) {
        
        guard let window = viewController.view.window else { return }
        
        if let overlay = window.subviews.first(where: { $0 is IndicatorOverlayView }) {
            
            UIView.animate(withDuration: 0.3, animations: {
                
                overlay.alpha = 0
                
            }) {
                isDone in
                
                overlay.removeFromSuperview()
            }
        }
    }
}
