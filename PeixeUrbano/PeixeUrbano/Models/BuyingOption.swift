//
//  BuyingOption.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 21/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct BuyingOption: Codable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "buying_option_id"
    }
}
