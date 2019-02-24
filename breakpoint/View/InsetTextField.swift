//
//  InsetTextField.swift
//  breakpoint
//
//  Created by Alex on 2/24/19.
//  Copyright © 2019 Alex Vozniuk. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {

    private var padding = UIEdgeInsetsMake(0, 20, 0, 20)
    
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib() 
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    func setupView() {
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.4647747874, green: 0.7745169401, blue: 0.3634208441, alpha: 1)])
        self.attributedPlaceholder = placeholder
    }
}
