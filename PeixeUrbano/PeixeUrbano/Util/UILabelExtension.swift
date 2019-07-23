//
//  UILabelExtension.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 22/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// Define the text color, font and text alignment of the label.
    ///
    /// - Parameters:
    ///   - textColor: The color of the text.
    ///   - font: The font used to display the text.
    ///   - textAlignment: The technique to use for aligning the text.
    func set(textColor: UIColor?, font: UIFont, textAlignment: NSTextAlignment) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
}
