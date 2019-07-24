//
//  CatalogPresenterTests.swift
//  PeixeUrbanoTests
//
//  Created by Matheus Cardoso kuhn on 23/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import XCTest

class CatalogPresenterTests: XCTestCase {

    //MARK: - Variables
    var presenter: CatalogPresenter?
    
    //MARK: - Life Cycle
    override func setUp() {
        presenter = CatalogPresenter()
    }

    override func tearDown() {
        presenter = nil
    }
    
    //MARK: - Util
    private class FakeViewController: CatalogDisplayLogic {
        
        var completionCatalog: ((Catalog.CatalogModel.ViewModel) -> Void)?
        var completionImage: ((Catalog.ImageModel.ViewModel) -> Void)?
        var completionBanner: ((Catalog.Banners.ViewModel) -> Void)?
        var completionLoader: ((Catalog.Loader.ViewModel) -> Void)?
        var completionFavorite: ((Catalog.Favorite.ViewModel) -> Void)?
        var completionError: ((Error) -> Void)?
        
        func displayCatalog(viewModel: Catalog.CatalogModel.ViewModel) {
            completionCatalog?(viewModel)
        }
        
        func displayImage(viewModel: Catalog.ImageModel.ViewModel) {
            completionImage?(viewModel)
        }
        
        func displayBanner(viewModel: Catalog.Banners.ViewModel) {
            completionBanner?(viewModel)
        }
        
        func displayLoader(viewModel: Catalog.Loader.ViewModel) {
            completionLoader?(viewModel)
        }
        
        func displayFavorite(viewModel: Catalog.Favorite.ViewModel) {
            completionFavorite?(viewModel)
        }
        
        func displayError(viewModel: Error) {
            completionError?(viewModel)
        }
    }
    
    private func createDeal(dealFormat: DealFormat, hasBuyingOptions: Bool, minSalePrice: NSNumber, fullprice: NSNumber) -> Deal {
        let buyingOptions = hasBuyingOptions ? [BuyingOption(id: "1"), BuyingOption(id: "2")] : []
        let newDeal = Deal(category: Name<Category>(value: "Deal"),
                           shortTitle: "Title",
                           partner: Partner(name: Name<Partner>(value: "Partner Name")),
                           images: [Image(imageUrl: "ImageURL")],
                           buyingOptions: buyingOptions,
                           percentageSaved: "25%",
                           dealFormat: dealFormat,
                           showDiscount: false,
                           minSalePrice: NSNumberCodable(value: minSalePrice),
                           fullPrice: NSNumberCodable(value: fullprice),
                           isFavorite: false)
        return newDeal
    }
    
    private func createBanner() -> Banner {
        let newBanner = Banner(mobile: Mobile(imageUrl: "ImgUrl",
                                              isActive: false))
        return newBanner
    }
    
    //MARK: - Tests Present Catalog
    func testDealModelIsImageCuttedVisibleFullContent() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 0.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertTrue(dealModel.isImageCuttedVisible)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelIsImageCuttedVisiblePartContent() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .noDiscountAndOrigialPrice,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 0.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertFalse(dealModel.isImageCuttedVisible)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelImageUrl() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 0.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.imageUrl, deal.images[0].imageUrl)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelPartnerName() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 0.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.partnerName, deal.partner.name.value)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelTitle() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 0.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.title, deal.shortTitle)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelPriceDescriptionValue() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 10.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.priceDescription, "R$ 10,00")
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelPriceDescriptionPorApenas() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .noDiscountAndOrigialPrice,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 10.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.priceDescription, "Por apenas")
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelPriceDescriptionApartir() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .noDiscountAndOrigialPrice,
                              hasBuyingOptions: true,
                              minSalePrice: 0.0,
                              fullprice: 10.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.priceDescription, "A partir de")
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelPriceSymbol() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 0.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.priceSymbol, "R$")
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelPrice() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 10.0,
                              fullprice: 0.0)
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.price, "10,00")
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelFavoriteImageTrue() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        var deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 0.0)
        deal.isFavorite = true
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.favoriteImage, UIImage(named: "heartFilled"))
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDealModelFavoriteImageFalse() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        var deal = createDeal(dealFormat: .fullContent,
                              hasBuyingOptions: false,
                              minSalePrice: 0.0,
                              fullprice: 0.0)
        deal.isFavorite = false
        fakeViewController.completionCatalog = { response in
            let dealModel = response.deals[0]
            XCTAssertEqual(dealModel.favoriteImage, UIImage(named: "heart"))
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [],
                                     categories: [],
                                     deals: [deal])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testBannerModelImageUrl() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        let banner = createBanner()
        fakeViewController.completionCatalog = { response in
            let bannerModel = response.banners[0]
            XCTAssertEqual(bannerModel.imageUrl, banner.mobile.imageUrl)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let catalog = CatalogReponse(hasMore: false,
                                     banners: [banner],
                                     categories: [],
                                     deals: [])
        let response = Catalog.CatalogModel.Response(catalog: catalog)
        presenter?.presentCatalog(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    //MARK: - Tests Present Image
    func testPresentImage() {
        let image = UIImage()
        let indexPath = IndexPath(row: 0, section: 0)
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionImage = { response in
            XCTAssertEqual(response.image, image)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.ImageModel.Response(image: image, indexPath: indexPath)
        presenter?.presentImage(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testPresentImageIndex() {
        let image = UIImage()
        let indexPath = IndexPath(row: 0, section: 0)
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionImage = { response in
            XCTAssertEqual(response.indexPath, indexPath)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.ImageModel.Response(image: image, indexPath: indexPath)
        presenter?.presentImage(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    //MARK: - Tests Present Banner
    func testPresentBanner() {
        let image = UIImage()
        let index = 0
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionBanner = { response in
            XCTAssertEqual(response.image, image)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.Banners.Response(image: image, index: index)
        presenter?.presentBanner(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testPresentBannerIndex() {
        let image = UIImage()
        let index = 0
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionBanner = { response in
            XCTAssertEqual(response.index, index)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.Banners.Response(image: image, index: index)
        presenter?.presentBanner(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    //MARK: - Tests Present Loader
    func testPresentLoaderTrue() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionLoader = { response in
            XCTAssertTrue(response.isLoaderVisible)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.Loader.Response(isLoaderVisible: true)
        presenter?.presentLoader(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testPresentLoaderFalse() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionLoader = { response in
            XCTAssertFalse(response.isLoaderVisible)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.Loader.Response(isLoaderVisible: false)
        presenter?.presentLoader(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    //MARK: - Tests Present Favorite
    func testPresentFavoriteTrue() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionFavorite = { response in
            XCTAssertEqual(response.favoriteImage, UIImage(named: "heartFilled"))
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.Favorite.Response(isFavorite: true,
                                                 row: 0)
        presenter?.presentFavorite(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testPresentFavoriteFalse() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionFavorite = { response in
            XCTAssertEqual(response.favoriteImage, UIImage(named: "heart"))
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.Favorite.Response(isFavorite: false,
                                                 row: 0)
        presenter?.presentFavorite(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    func testPresentFavoriteRow() {
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionFavorite = { response in
            XCTAssertEqual(response.row, 0)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        let response = Catalog.Favorite.Response(isFavorite: false,
                                                 row: 0)
        presenter?.presentFavorite(response: response)
        wait(for: [expectation], timeout: 1)
    }
    
    //MARK: - Tests Present Error
    func testPresentError() {
        let error = NSError(domain: "Teste", code: -1, userInfo: nil)
        let expectation = XCTestExpectation(description: "completion")
        let fakeViewController = FakeViewController()
        fakeViewController.completionError = { response in
            XCTAssertEqual(response.localizedDescription, error.localizedDescription)
            expectation.fulfill()
        }
        presenter?.viewController = fakeViewController
        presenter?.presentError(response: error)
        wait(for: [expectation], timeout: 1)
    }
}
