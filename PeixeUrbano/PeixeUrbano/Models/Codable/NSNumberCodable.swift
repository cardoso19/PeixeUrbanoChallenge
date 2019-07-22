//
//  NSNumberCodable.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 21/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

/// A codable version of NSNumber.
///
/// NSNumberCodable can decode a double to a NSNumber and encode a NSNumber to a double.
struct NSNumberCodable: Codable {
    let value: NSNumber?
    
    init(value: NSNumber?) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        self.value = try NSNumber(value: Double(from: decoder))
    }
    
    func encode(to encoder: Encoder) throws {
        try value?.doubleValue.encode(to: encoder)
    }
}
