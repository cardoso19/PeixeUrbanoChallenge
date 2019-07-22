//
//  CatalogReponse.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

struct CatalogReponse: Codable {
    let hasMore: Bool
    let banners: [Banner]
    let categories: [Category]
    let deals: [Deal]
}
