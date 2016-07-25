//
//  MaterialVIew.swift
//  SocialMedia-Project
//
//  Created by Eric Pinedo on 7/19/16.
//  Copyright © 2016 Eric PInedo. All rights reserved.
//

import UIKit

class MaterialVIew: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }

}
