//
//  DateCodable.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

/// A codable version of Date.
///
/// DateCodable can decode a string in format 'yyyy-MM-dd' to a Date and encode a Date to a string in format 'yyyy-MM-dd'.
struct DateCodable: Codable {
    let value: Date?
    
    init(value: Date?) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        self.value = try String(from: decoder).convertToDate(ofFormat: "yyyy-MM-dd")
    }
    
    func encode(to encoder: Encoder) throws {
        try value?.convertToString(onFormat: "yyyy-MM-dd").encode(to: encoder)
    }
}
