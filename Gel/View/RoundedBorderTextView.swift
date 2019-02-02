//
//  RoundedBorderTextView.swift
//  Gel
//
//  Created by Admin on 3.02.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class RoundedBorderTextView: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customization()
    }
    
    func customization(){
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)])
        self.attributedPlaceholder = placeholder
        self.backgroundColor = .white
        self.layer.cornerRadius = frame.height / 4
        self.layer.borderColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        self.layer.borderWidth = 2
    }
}
