//
//  ExpressTextField.swift
//  KeepExpress
//
//  Created by jackrex on 12/1/2017.
//  Copyright © 2017 jackrex. All rights reserved.
//

import UIKit

class ExpressTextField: UITextField {
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }
}
