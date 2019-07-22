//
//  Mobile.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct Mobile: Codable {
    let imageUrl: String
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "mobile_image"
        case isActive = "active"
    }
}
