//
//  Category.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct Category: Codable {
    let name: Name<Category>
    let isVisible: Bool
    let isVisibleInMobile: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case isVisible = "visible"
        case isVisibleInMobile = "mobile"
    }
}
