//
//  StringExtension.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

extension String {
    
    /// Try to convert a string to a date of the requested format.
    ///
    /// - Parameter format: the date format.
    /// - Returns: A date with the requested format or nil.
    func convertToDate(ofFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
