//
//  UIViewKeyboardExt.swift
//  breakpoint
//
//  Created by Alex on 3/27/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import UIKit

extension UIView {
    
func bindKeyboard() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y + 34

        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y+=deltaY
        },completion: nil)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
       self.frame.origin.y = 0
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.frame.origin.y == 0 {
//                self.frame.origin.y -= keyboardSize.height + 34
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.frame.origin.y != 0 {
//            self.frame.origin.y = 0
//        }
//    }

}
