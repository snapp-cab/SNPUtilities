//
//  SNPKeybordHeightConstraint.swift
//  Pods-SNPUtilities_Example
//
//  Created by farhad jebelli on 7/31/18.
//

import Foundation
@IBDesignable
class SNPKeybordHeightConstraint: NSLayoutConstraint {
    
    @IBInspectable var useSafeArea: Bool = true
    @IBInspectable var margin: CGFloat = 0

    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(123)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordFrameChanged), name: .UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordHide), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keybordShow), name: .UIKeyboardWillShow, object: nil)
        
    }
    
    //MARK: HandleKeyBord
    var isKeybordHide:Bool = true
    @objc func keybordFrameChanged(notification: Notification) {
        setKeybordHeigth(notification: notification)
    }
    @objc func keybordShow(notification: Notification) {
        isKeybordHide = false
        setKeybordHeigth(notification: notification)
        
    }
    @objc func keybordHide(notification: Notification) {
        isKeybordHide = true
        self.constant = 0
    }
    func setKeybordHeigth(notification: Notification){
        if !isKeybordHide {
            guard let userInfo = notification.userInfo, let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else{
                return
            }
            guard let view = UIApplication.shared.keyWindow?.rootViewController?.view else {
                return
            }
            let convertedFrame = view.convert(frame, from: UIScreen.main.coordinateSpace)
            let intersectedKeyboardHeight = view.frame.intersection(convertedFrame).height
            
            var height = intersectedKeyboardHeight
            if useSafeArea {
                let bottom: CGFloat
                if #available(iOS 11.0, *) {
                    bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
                } else {
                    bottom = UIApplication.shared.keyWindow?.layoutMargins.bottom ?? 0
                }
                if height > bottom {
                    height -= bottom
                }
            }
            UIView.animate(withDuration: 0.3, animations: { [unowned self] in
                self.constant = height + self.margin
                view.layoutIfNeeded()
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
