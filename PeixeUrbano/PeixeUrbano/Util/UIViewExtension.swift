//
//  UIViewExtension.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 22/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Set false in translatesAutoresizingMaskIntoConstraints of many views.
    ///
    /// - Parameter views: views that will disable the translation.
    class func disableTranslatesAutoresizingMaskIntoConstraints(on views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    /// Sets the priority with which a view resists being made smaller than its intrinsic size.
    ///
    /// It calls the apple's method setContentCompressionResistancePriority to each value in arrays, and it uses indexes to order those sets.
    ///
    /// - Parameters:
    ///   - priorities: The new priorities.
    ///   - axes: The axes for which the compression resistance priority should be set.
    func setContentCompressionResistancePriority(to priorities: [UILayoutPriority], in axes: [NSLayoutConstraint.Axis]) {
        guard
            priorities.count == axes.count
            else {
                fatalError("Error trying to set content compression resistence priority.")
        }
        for (index, axis) in axes.enumerated() {
            self.setContentCompressionResistancePriority(priorities[index], for: axis)
        }
    }
    
    /// Sets the priority with which a view resists being made larger than its intrinsic size.
    ///
    /// It calls the apple's method setContentHuggingPriority to each value in arrays, and it uses indexes to order those sets.
    ///
    /// - Parameters:
    ///   - priorities: The new priorities.
    ///   - axes: The axes for which the content hugging priority should be set.
    func setContentHuggingPriority(to priorities: [UILayoutPriority], in axes: [NSLayoutConstraint.Axis]) {
        guard
            priorities.count == axes.count
            else {
                fatalError("Error trying to set content hugging priority.")
        }
        for (index, axis) in axes.enumerated() {
            self.setContentHuggingPriority(priorities[index], for: axis)
        }
    }
}
