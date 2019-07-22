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
        configColors()
        configButtons()
    }
    
    //MARK: - Layout
    private func configColors() {
        navigationBar.barTintColor = UIColor.mainBlue
        navigationBar.tintColor = .white
    }
    
    private func configButtons() {
        
    }
}
