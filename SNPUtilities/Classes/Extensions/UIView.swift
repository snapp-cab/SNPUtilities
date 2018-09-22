//
//  UIView.swift
//  Pods-SNPUtilities_Example
//
//  Created by farhad jebelli on 7/9/18.
//

import UIKit

extension UIView {
    public func addExpletiveSubView (view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    public func shake() {
        func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
            let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.repeatCount = count
            animation.duration = duration/TimeInterval(animation.repeatCount)
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-translation), y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(translation), y: self.center.y))
            layer.add(animation, forKey: "shake")
        }
    }
}
