//
//  BannerTableViewCell.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 22/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    //MARK: - Visual Components
    private weak var scrollView: UIScrollView!
    private weak var pageControl: UIPageControl!
    private let scrollViewHeight: CGFloat = 280
    private var arrayBannersView: [UIImageView]?
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareLayout()
    }
    
    //MARK: - Content
    func setNumberOfBanners(_ number: Int) {
        pageControl.numberOfPages = number
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width * CGFloat(number),
                                        height: scrollViewHeight)
        createBannersViews(number: number)
    }
    
    func add(image: UIImage?, at index: Int) {
        arrayBannersView?[index].image = image
    }
    
    private func createBannersViews(number: Int) {
        removeBannersViews()
        arrayBannersView = []
        for index in 0..<number {
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: UIScreen.main.bounds.size.width * CGFloat(index),
                                                                      y: 0),
                                                      size: CGSize(width: UIScreen.main.bounds.size.width,
                                                                   height: scrollViewHeight)))
            scrollView.addSubview(imageView)
            arrayBannersView?.append(imageView)
        }
    }
    
    private func removeBannersViews() {
        guard let arrayBannersView = arrayBannersView else { return }
        for view in arrayBannersView {
            view.removeFromSuperview()
        }
        self.arrayBannersView = nil
    }
    
    //MARK: - Layout
    private func prepareLayout() {
        createComponents()
        configScrollView()
        configPageControl()
    }
    
    private func createComponents() {
        let scrollView = UIScrollView()
        let pageControl = UIPageControl()
        addSubview(scrollView)
        addSubview(pageControl)
        
        self.scrollView = scrollView
        self.pageControl = pageControl
        UIView.disableTranslatesAutoresizingMaskIntoConstraints(on: [scrollView,
                                                                     pageControl])
        createConstraints(on: ["scrollView": scrollView,
                               "pageControl": pageControl])
        layoutIfNeeded()
    }
    
    private func configScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
    }
    
    private func configPageControl() {
        pageControl.isUserInteractionEnabled = false
    }
    
    private func createConstraints(on views: [String: UIView]) {
        guard let pageControl = pageControl
            else {
                fatalError("Error page control not defined.")
        }
        var allConstraints: [NSLayoutConstraint] = []
        let scrollViewHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[scrollView]-0-|",
            metrics: nil,
            views: views)
        allConstraints += scrollViewHorizontalConstraint
        let scrollViewVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[scrollView(height)]-16-|",
            metrics: ["height": scrollViewHeight],
            views: views)
        allConstraints += scrollViewVerticalConstraint
        let pageControlVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[pageControl]-20-|",
            metrics: nil,
            views: views)
        allConstraints += pageControlVerticalConstraint
        let pageControlCenterConstraint = NSLayoutConstraint(item: pageControl,
                                                             attribute: .centerX,
                                                             relatedBy: .equal,
                                                             toItem: self,
                                                             attribute: .centerX,
                                                             multiplier: 1.0,
                                                             constant: 0.0)
        allConstraints.append(pageControlCenterConstraint)
        NSLayoutConstraint.activate(allConstraints)
    }
}

//MARK: - UIScrollViewDelegate
extension BannerTableViewCell: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenWidth = UIScreen.main.bounds.size.width
        let page: Int = Int(scrollView.contentOffset.x / screenWidth)
        pageControl.currentPage = page
    }
}
