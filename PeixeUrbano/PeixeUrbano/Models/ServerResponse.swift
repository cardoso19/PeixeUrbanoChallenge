//
//  ServerResponse.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import Foundation

/// The default server response type.
///
/// ServerResponse is a generic model that receives responses of type Codable.
struct ServerResponse<T>: Codable where T: Codable {
    let code: Int
    let response: T
}
