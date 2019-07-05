//
//  WindDirectionView.swift
//  WeatherTest
//
//  Created by Nikita Gorobets on 05/07/2019.
//  Copyright © 2019 ng. All rights reserved.
//

import UIKit

class WindDirectionView: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let lineWidth: CGFloat = 4
        let margin: CGFloat = lineWidth / 2.0
        
        let startPoint = CGPoint(x: margin, y: bounds.maxY)
        let leftPoint = CGPoint(x: margin, y: bounds.maxY * 0.3)
        let topCenterPoint = CGPoint(x: bounds.midX, y: margin)
        let rightPoint = CGPoint(x: bounds.maxX - margin, y: bounds.maxY * 0.3)
        let endPoint = CGPoint(x: bounds.maxX - margin, y: bounds.maxY)
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: leftPoint)
        path.addLine(to: topCenterPoint)
        path.addLine(to: rightPoint)
        path.addLine(to: endPoint)
        path.lineWidth = lineWidth
        AppColors.white.uiColor.setStroke()
        path.stroke()
    }
    
    func rotateTo(angle: CGFloat, animated: Bool) {
        
        let rotation = CGAffineTransform(rotationAngle: angle * (.pi / 180.0))
        
        UIView.animate(withDuration: animated ? 1 : 0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.5, options: .curveEaseInOut, animations: {
            
            self.transform = rotation
        })
    }
}
