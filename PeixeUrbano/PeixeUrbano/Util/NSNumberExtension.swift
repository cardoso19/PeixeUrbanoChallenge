//
//  NSNumberExtension.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 21/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

extension NSNumber {
    
    /// Format a NSNumber to a string on currency format without the currency symbol.
    ///
    /// - Returns: A string on currency format.
    func formatToCurrencyWithOutSymbol() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-Br")
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self)
    }
}
