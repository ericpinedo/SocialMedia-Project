//
//  MaterialTextField.swift
//  SocialMedia-Project
//
//  Created by Eric Pinedo on 7/19/16.
//  Copyright © 2016 Eric PInedo. All rights reserved.
//

import UIKit

class MaterialTextField: UITextField {
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.borderWidth = 1.0
        
    }
        //for placeholder
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
        
    }
    //editable text
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, 10, 0)
    }
    
}
