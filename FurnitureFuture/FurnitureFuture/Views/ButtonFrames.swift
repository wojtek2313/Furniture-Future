//
//  ButtonFrames.swift
//  FurnitureFuture
//
//  Created by Wojtek on 05/10/2018.
//  Copyright © 2018 Wojtek. All rights reserved.
//

import UIKit

class ButtonFrames: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
    }
}
