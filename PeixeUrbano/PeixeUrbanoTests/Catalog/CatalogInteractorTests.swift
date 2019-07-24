//
//  CatalogInteractorTests.swift
//  PeixeUrbanoTests
//
//  Created by Matheus Cardoso kuhn on 20/07/19.
//  Copyright © 2019 MDT. All rights reserved.
//

import XCTest
@testable import PeixeUrbano

class CatalogInteractorTests: XCTestCase {

    //MARK: - Variables
    var interactor: CatalogInteractor?
    
    //MARK: - Life Cycle
    override func setUp() {
        interactor = CatalogInteractor()
    }

    override func tearDown() {
        interactor = nil
    }

    //MARK: - Util
    private class FakePresenter: CatalogPresentationLogic {
        
        var completionFavorite: ((Catalog.Favorite.Response) -> Void)?
        
        func presentFavorite(response: Catalog.Favorite.Response) {
            completionFavorite?(response)
        }
        
        func presentCatalog(response: Catalog.CatalogModel.Response) {}
        func presentImage(response: Catalog.ImageModel.Response) {}
        func presentBanner(response: Catalog.Banners.Response) {}
        func presentLoader(response: Catalog.Loader.Response) {}
        func presentError(response: Error) {}
    }
    
    private func createDeal() -> Deal {
        let newDeal = Deal(category: Name<Category>(value: "Deal"),
                           shortTitle: "Title",
                           partner: Partner(name: Name<Partner>(value: "Partner Name")),
                           images: [Image(imageUrl: "ImageURL")],
                           buyingOptions: [BuyingOption(id: "1")],
                           percentageSaved: "25%",
                           dealFormat: .fullContent,
                           showDiscount: false,
                           minSalePrice: NSNumberCodable(value: 9.99),
                           fullPrice: NSNumberCodable(value: 10.0),
                           isFavorite: false)
        return newDeal
    }
    
    //MARK: - Tests
    func testSelectCatalogType() {
        let request = Catalog.TypeModel.Request(type: .city)
        interactor?.selectCatalogType(request: request)
        XCTAssertEqual(interactor?.type, .city)
    }
    
    func testDoFavoriteChangeOfValueTrue() {
        var deal = createDeal()
        deal.isFavorite = false
        interactor?.deals = [deal]
        let request = Catalog.Favorite.Request(row: 0)
        interactor?.doFavorite(request: request)
        XCTAssertEqual(interactor?.deals?[0].isFavorite, true)
    }
    
    func testDoFavoriteChangeOfValueFalse() {
        var deal = createDeal()
        deal.isFavorite = true
        interactor?.deals = [deal]
        let request = Catalog.Favorite.Request(row: 0)
        interactor?.doFavorite(request: request)
        XCTAssertEqual(interactor?.deals?[0].isFavorite, false)
    }
    
    func testDoFavoriteRowValue() {
        let row = 0
        let expectation = XCTestExpectation(description: "completion")
        let fakePresenter = FakePresenter()
        let deal = createDeal()
        fakePresenter.completionFavorite = { response in
            XCTAssertEqual(response.row, row)
            expectation.fulfill()
        }
        interactor?.deals = [deal]
        interactor?.presenter = fakePresenter
        let request = Catalog.Favorite.Request(row: row)
        interactor?.doFavorite(request: request)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDoFavoriteRowResponseValueTrue() {
        let expectation = XCTestExpectation(description: "completion")
        let fakePresenter = FakePresenter()
        var deal = createDeal()
        deal.isFavorite = false
        fakePresenter.completionFavorite = { response in
            XCTAssertTrue(response.isFavorite)
            expectation.fulfill()
        }
        interactor?.deals = [deal]
        interactor?.presenter = fakePresenter
        let request = Catalog.Favorite.Request(row: 0)
        interactor?.doFavorite(request: request)
        wait(for: [expectation], timeout: 1)
    }
    
    func testDoFavoriteRowResponseValueFalse() {
        let expectation = XCTestExpectation(description: "completion")
        let fakePresenter = FakePresenter()
        var deal = createDeal()
        deal.isFavorite = true
        fakePresenter.completionFavorite = { response in
            XCTAssertFalse(response.isFavorite)
            expectation.fulfill()
        }
        interactor?.deals = [deal]
        interactor?.presenter = fakePresenter
        let request = Catalog.Favorite.Request(row: 0)
        interactor?.doFavorite(request: request)
        wait(for: [expectation], timeout: 1)
    }
}
