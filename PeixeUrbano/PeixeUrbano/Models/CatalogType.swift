//
//  CatalogType.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 21/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

enum CatalogType {
    case city
    case travel
    case products
    
    var title: String {
        switch self {
        case .city:
            return "Na cidade"
        case .travel:
            return "Viagens"
        case .products:
            return "Produtos"
        }
    }
    
    var tabBarIcon: UIImage? {
        switch self {
        case .city:
            return UIImage(named: "city")
        case .travel:
            return UIImage(named: "travel")
        case .products:
            return UIImage(named: "products")
        }
    }
    
    var requestURL: URL? {
        switch self {
        case .city:
            return URL(string: "https://gist.githubusercontent.com/insidegui/2b1f747ebeb9070e33818bf857e28a84/raw/5da63767fda2ec16f4ae0718e3be4be75001fe10/florianopolis.json")
        case .travel:
            return URL(string: "https://gist.githubusercontent.com/insidegui/d2665b556f2be1b1ad3a19d2ef9bcc44/raw/afe1e0a9563e3bcddc3796b22becb8f12f82ee2e/viagens.json")
        case .products:
            return URL(string: "https://gist.githubusercontent.com/insidegui/007fd6664650391dca199e6784d1f351/raw/862d701c69307f9e9053f8cb1ec438586fca4b64/produtos.json")
        }
    }
}
