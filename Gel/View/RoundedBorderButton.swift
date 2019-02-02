//
//  RoundedBorderButton.swift
//  Gel
//
//  Created by Admin on 2.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

@IBDesignable class RoundedBorderButton: UIButton {

    override func prepareForInterfaceBuilder() {
        customization()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        customization()
    }
    func customization(){
        self.layer.cornerRadius = frame.height / 4
        self.layer.borderWidth = 2.0
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.backgroundColor = .clear
    }

}
