//
//  Deal.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct Deal: Codable {
    let category: Name<Category>
    let shortTitle: String
    let partner: Partner
    let images: [Image]
    let buyingOptions: [BuyingOption]
    let percentageSaved: String
    let dealFormat: DealFormat
    let showDiscount: Bool
    let minSalePrice: NSNumberCodable
    let fullPrice: NSNumberCodable
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case category = "deal_category"
        case shortTitle = "short_title"
        case partner
        case images
        case buyingOptions = "buying_options"
        case percentageSaved = "percentage_saved"
        case dealFormat = "deal_format"
        case showDiscount = "show_discount"
        case minSalePrice = "min_sale_price"
        case fullPrice = "full_price"
    }
}
