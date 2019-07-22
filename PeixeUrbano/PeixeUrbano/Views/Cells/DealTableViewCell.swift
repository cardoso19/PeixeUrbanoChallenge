//
//  DealTableViewCell.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

class DealTableViewCell: UITableViewCell {
    
    //MARK: - Visual Components
    weak var imageViewDeal: UIImageView!
    weak var imageViewCutted: UIImageView!
    weak var labelPartnerName: UILabel!
    weak var labelDealTitle: UILabel!
    weak var labelDealPriceDescription: UILabel!
    weak var labelDealPriceSymbol: UILabel!
    weak var labelDealPrice: UILabel!
    weak var buttonFavorite: UIButton!
    private weak var gradientLayer: CAGradientLayer!
    private let imageViewDealHeight: CGFloat = 250
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareLayout()
    }
    
    //MARK: - Layout
    private func prepareLayout() {
        createComponents()
        layoutLabels()
        layoutImage()
        layoutButton()
    }
    
    private func createComponents() {
        let viewTop = UIView()
        let viewPriceDescription = UIView()
        let imageViewDeal = UIImageView()
        let imageViewCutted = UIImageView()
        let labelPartnerName = UILabel()
        let buttonFavorite = UIButton()
        let labelDealTitle = UILabel()
        let labelDealPriceDescription = UILabel()
        let labelDealPriceSymbol = UILabel()
        let labelDealPrice = UILabel()
        let stackViewPriceValue = UIStackView(arrangedSubviews: [labelDealPriceSymbol, labelDealPrice])
        let stackViewPrice = UIStackView(arrangedSubviews: [viewPriceDescription, stackViewPriceValue])
        let stackViewBottom = UIStackView(arrangedSubviews: [labelDealTitle, stackViewPrice])
        viewTop.addSubview(imageViewDeal)
        viewTop.addSubview(labelPartnerName)
        viewTop.addSubview(buttonFavorite)
        viewPriceDescription.addSubview(labelDealPriceDescription)
        viewPriceDescription.addSubview(imageViewCutted)
        contentView.addSubview(viewTop)
        contentView.addSubview(stackViewBottom)
        stackViewPrice.axis = .vertical
        stackViewBottom.axis = .horizontal
        stackViewPriceValue.axis = .horizontal
        stackViewPrice.spacing = 8
        stackViewBottom.spacing = 16
        stackViewPriceValue.spacing = 2
        stackViewBottom.distribution = .fillProportionally
        stackViewPrice.alignment = .center
        labelDealPriceSymbol.setContentCompressionResistancePriority(.required,
                                                                     for: .horizontal)
        labelDealPriceDescription.setContentCompressionResistancePriority(.required,
                                                                          for: .horizontal)
        labelDealPrice.setContentCompressionResistancePriority(.required,
                                                               for: .horizontal)
        labelDealPriceSymbol.setContentCompressionResistancePriority(.required,
                                                                     for: .vertical)
        labelDealPriceDescription.setContentCompressionResistancePriority(.required,
                                                                          for: .vertical)
        labelDealPrice.setContentCompressionResistancePriority(.required,
                                                               for: .vertical)
        self.imageViewDeal = imageViewDeal
        self.imageViewCutted = imageViewCutted
        self.labelPartnerName = labelPartnerName
        self.buttonFavorite = buttonFavorite
        self.labelDealTitle = labelDealTitle
        self.labelDealPriceDescription = labelDealPriceDescription
        self.labelDealPriceSymbol = labelDealPriceSymbol
        self.labelDealPrice = labelDealPrice
        let views: [String: UIView] = ["viewTop": viewTop,
                                       "viewPriceDescription": viewTop,
                                       "imageViewDeal": imageViewDeal,
                                       "imageViewCutted": imageViewCutted,
                                       "labelPartnerName": labelPartnerName,
                                       "buttonFavorite": buttonFavorite,
                                       "labelDealTitle": labelDealTitle,
                                       "labelDealPriceDescription": labelDealPriceDescription,
                                       "labelDealPriceSymbol": labelDealPriceSymbol,
                                       "labelDealPrice": labelDealPrice,
                                       "stackViewPriceValue": stackViewPriceValue,
                                       "stackViewPrice": stackViewPrice,
                                       "stackViewBottom": stackViewBottom]
        createConstraints(on: views)
        layoutIfNeeded()
    }
    
    private func layoutLabels() {
        labelPartnerName.textColor = UIColor.textLightGray
        labelPartnerName.font = UIFont.systemFont(ofSize: 16)
        labelDealTitle.textColor = UIColor.textBlack
        labelDealTitle.font = UIFont.systemFont(ofSize: 16)
        labelDealTitle.numberOfLines = 2
        labelDealTitle.textAlignment = .left
        labelDealPriceDescription.textColor = UIColor.textGray
        labelDealPriceDescription.font = UIFont.systemFont(ofSize: 14)
        labelDealPriceDescription.textAlignment = .center
        labelDealPriceSymbol.textColor = UIColor.mainOrange
        labelDealPriceSymbol.font = UIFont.systemFont(ofSize: 14)
        labelDealPriceSymbol.textAlignment = .center
        labelDealPrice.textColor = UIColor.mainOrange
        labelDealPrice.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        labelDealPrice.textAlignment = .center
    }
    
    private func layoutImage() {
        let initialColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        let finalColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: .zero,
                                size: CGSize(width: UIScreen.main.bounds.width,
                                             height: imageViewDealHeight))
        gradient.colors = [initialColor.cgColor, finalColor.cgColor]
        gradient.locations = [0.75, 1.0]
        imageViewDeal.layer.addSublayer(gradient)
        gradientLayer = gradient
        imageViewCutted.image = UIImage(named: "cutted")
        imageViewCutted.isHidden = true
    }
    
    private func layoutButton() {
        buttonFavorite.contentEdgeInsets = UIEdgeInsets(top: 10,
                                                        left: 10,
                                                        bottom: 10,
                                                        right: 10)
        buttonFavorite.setImage(UIImage(named: "heart"), for: .normal)
        buttonFavorite.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        buttonFavorite.layer.cornerRadius = buttonFavorite.bounds.width / 2
    }
    
    private func createConstraints(on views: [String: UIView]) {
        disableAutoresizingMask(on: views)
        var allConstraints: [NSLayoutConstraint] = []
        let topContentHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[labelPartnerName]-16-[buttonFavorite(40)]-16-|",
            options: [.alignAllBottom],
            metrics: nil,
            views: views)
        allConstraints += topContentHorizontalConstraint
        let topContentVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:[buttonFavorite(40)]-16-|",
            metrics: nil,
            views: views)
        allConstraints += topContentVerticalConstraint
        let imageHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[imageViewDeal]-0-|",
            metrics: nil,
            views: views)
        allConstraints += imageHorizontalConstraint
        let imageVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[imageViewDeal(imageHeight)]-0-|",
            metrics: ["imageHeight": imageViewDealHeight],
            views: views)
        allConstraints += imageVerticalConstraint
        let viewTopHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[viewTop]-0-|",
            metrics: nil,
            views: views)
        allConstraints += viewTopHorizontalConstraint
        let stackBottomHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-16-[stackViewBottom]-16-|",
            metrics: nil,
            views: views)
        allConstraints += stackBottomHorizontalConstraint
        let contentVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[viewTop]-16-[stackViewBottom]-16-|",
            metrics: nil,
            views: views)
        allConstraints += contentVerticalConstraint
        let labelPriceDescriptionHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[labelDealPriceDescription]-0-|",
            metrics: nil,
            views: views)
        allConstraints += labelPriceDescriptionHorizontalConstraint
        let labelPriceDescriptionVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[labelDealPriceDescription]-0-|",
            metrics: nil,
            views: views)
        allConstraints += labelPriceDescriptionVerticalConstraint
        let imageCuttedHorizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[imageViewCutted]-0-|",
            metrics: nil,
            views: views)
        allConstraints += imageCuttedHorizontalConstraint
        let imageCuttedVerticalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[imageViewCutted]-0-|",
            metrics: nil,
            views: views)
        allConstraints += imageCuttedVerticalConstraint
        NSLayoutConstraint.activate(allConstraints)
    }
    
    private func disableAutoresizingMask(on views: [String: UIView]) {
        for item in views.enumerated() {
            item.element.value.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
