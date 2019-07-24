//
//  DefaultNavigationController.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class DefaultNavigationController: UINavigationController {

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLayout()
    }
    
    //MARK: - Layout
    private func prepareLayout() {
        navigationBar.barTintColor = .mainBlue
        navigationBar.tintColor = .white
    }
}
