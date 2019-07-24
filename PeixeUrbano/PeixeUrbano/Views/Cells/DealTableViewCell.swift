//
//  DealTableViewCell.swift
//  PeixeUrbano
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import UIKit

/// The methods declared by DealTableViewCellDelegate handle the user interaction on DealTableViewCell.
protocol DealTableViewCellDelegate: NSObjectProtocol {
    /// The method called after the touchUpInside event on the favorite button.
    ///
    /// - Parameter tag: The tag value of the button.
    func didTouchUpInsideFavorite(on tag: Int)
}

/// An UITableViewCell that displays deal information.
class DealTableViewCell: UITableViewCell {
    
    //MARK: - Visual Components
    /// An UIImageView that shows the deal's image.
    weak var imageViewDeal: UIImageView!
    /// An UIImageView that shows the image of a line overhead the price description's label.
    weak var imageViewCutted: UIImageView!
    /// An UILabel that shows the Partner's name.
    weak var labelPartnerName: UILabel!
    /// An UILabel that shows the deal's short title.
    weak var labelDealTitle: UILabel!
    /// An UILabel that shows the description above the price value.
    weak var labelDealPriceDescription: UILabel!
    /// An UILabel that shows the currency symbol on the left of the price value.
    weak var labelDealPriceSymbol: UILabel!
    /// An UILabel that shows the deal's minimum sale price.
    weak var labelDealPrice: UILabel!
    /// An UIButton that shows the deal's favorite status.
    weak var buttonFavorite: UIButton!
    private weak var gradientLayer: CAGradientLayer!
    private let imageViewDealHeight: CGFloat = 250
    weak var delegate: DealTableViewCellDelegate?
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareLayout()
    }
    
    //MARK: - Actions
    @objc private func actionFavorite(sender: UIButton) {
        delegate?.didTouchUpInsideFavorite(on: sender.tag)
    }
    
    //MARK: - Layout
    private func prepareLayout() {
        createVisualComponents()
        layoutLabels()
        layoutImage()
        layoutButton()
        addGradientLayer()
        configButtonAction()
    }
    
    private func createVisualComponents() {
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
        
        self.imageViewDeal = imageViewDeal
        self.imageViewCutted = imageViewCutted
        self.labelPartnerName = labelPartnerName
        self.buttonFavorite = buttonFavorite
        self.labelDealTitle = labelDealTitle
        self.labelDealPriceDescription = labelDealPriceDescription
        self.labelDealPriceSymbol = labelDealPriceSymbol
        self.labelDealPrice = labelDealPrice
        UIView.disableTranslatesAutoresizingMaskIntoConstraints(on: [viewTop,
                                                                     viewPriceDescription,
                                                                     imageViewDeal,
                                                                     imageViewCutted,
                                                                     labelPartnerName,
                                                                     buttonFavorite,
                                                                     labelDealTitle,
                                                                     labelDealPriceDescription,
                                                                     labelDealPriceSymbol,
                                                                     labelDealPrice,
                                                                     stackViewPriceValue,
                                                                     stackViewPrice,
                                                                     stackViewBottom])
        layout(stackViews: ["stackViewPrice": stackViewPrice,
                            "stackViewBottom": stackViewBottom,
                            "stackViewPriceValue": stackViewPriceValue])
        createConstraints(on: ["labelPartnerName": labelPartnerName,
                               "buttonFavorite": buttonFavorite,
                               "imageViewDeal": imageViewDeal,
                               "viewTop": viewTop,
                               "stackViewBottom": stackViewBottom,
                               "labelDealPriceDescription": labelDealPriceDescription,
                               "imageViewCutted": imageViewCutted])
        layoutIfNeeded()
    }
    
    private func layoutLabels() {
        labelDealTitle.numberOfLines = 2
        labelPartnerName.set(textColor: .textLightGray,
                             font: UIFont.systemFont(ofSize: 16),
                             textAlignment: .left)
        labelDealTitle.set(textColor: .textBlack,
                           font: UIFont.systemFont(ofSize: 16),
                           textAlignment: .left)
        labelDealPriceDescription.set(textColor: .textGray,
                                      font: UIFont.systemFont(ofSize: 14),
                                      textAlignment: .center)
        labelDealPriceSymbol.set(textColor: .mainOrange,
                                 font: UIFont.systemFont(ofSize: 14),
                                 textAlignment: .center)
        labelDealPrice.set(textColor: .mainOrange,
                           font: UIFont.systemFont(ofSize: 18, weight: .semibold),
                           textAlignment: .center)
        
        labelDealPriceSymbol.setContentCompressionResistancePriority(to: [.required, .required],
                                                                     in: [.vertical, .horizontal])
        labelDealPriceDescription.setContentCompressionResistancePriority(to: [.required, .required],
                                                                          in: [.vertical, .horizontal])
        labelDealPrice.setContentCompressionResistancePriority(to: [.required, .required],
                                                               in: [.vertical, .horizontal])
    }
    
    private func layoutImage() {
        imageViewCutted.image = UIImage(named: "cutted")
        imageViewCutted.isHidden = true
    }
    
    private func layoutButton() {
        buttonFavorite.contentEdgeInsets = UIEdgeInsets(top: 10,
                                                        left: 10,
                                                        bottom: 10,
                                                        right: 10)
        buttonFavorite.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        buttonFavorite.layer.cornerRadius = buttonFavorite.bounds.width / 2
    }
    
    private func layout(stackViews: [String: UIStackView]) {
        guard
            let stackViewPrice = stackViews["stackViewPrice"],
            let stackViewBottom = stackViews["stackViewBottom"],
            let stackViewPriceValue = stackViews["stackViewPriceValue"]
            else {
                fatalError("Stackviews not defined")
        }
        stackViewPrice.axis = .vertical
        stackViewBottom.axis = .horizontal
        stackViewPriceValue.axis = .horizontal
        stackViewPrice.spacing = 8
        stackViewBottom.spacing = 16
        stackViewPriceValue.spacing = 2
        stackViewBottom.distribution = .fillProportionally
        stackViewPrice.alignment = .center
    }
    
    private func addGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(origin: .zero,
                                size: CGSize(width: UIScreen.main.bounds.width,
                                             height: imageViewDealHeight))
        gradient.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor]
        gradient.locations = [0.75, 1.0]
        imageViewDeal.layer.addSublayer(gradient)
        gradientLayer = gradient
    }
    
    private func configButtonAction() {
        buttonFavorite.addTarget(self, action: #selector(actionFavorite(sender:)), for: .touchUpInside)
    }
    
    private func createConstraints(on views: [String: UIView]) {
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
}
