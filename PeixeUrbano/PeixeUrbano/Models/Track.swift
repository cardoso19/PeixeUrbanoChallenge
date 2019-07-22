//
//  TrackImage.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 21/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

struct TrackImage {
    let url: URL
    let completion: (Result<UIImage, Error>) -> Void
    var downloaded: Bool = false
}
