//
//  HomeTabBarController.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class HomeTabBarController: UITabBarController {

    //MARK: - Life Cycle
    convenience init(viewControllers: [UIViewController]) {
        self.init()
        setViewControllers(viewControllers, animated: false)
        tabBar.tintColor = UIColor.mainOrange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
