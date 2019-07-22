//
//  Banner.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct Banner: Codable {
    let priority: Int
    let startDate: DateCodable
    let endDate: DateCodable
    let mobile: Mobile
    
    enum CodingKeys: String, CodingKey {
        case priority
        case startDate = "start_date"
        case endDate = "end_date"
        case mobile
    }
}
