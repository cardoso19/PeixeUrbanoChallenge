//
//  Image.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct Image: Codable {
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image"
    }
}

