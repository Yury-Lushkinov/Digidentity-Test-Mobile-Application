//
//  ItemsListPresenterTest.swift
//  Digidentity-Test-Mobile-ApplicationTests
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import XCTest
@testable import Digidentity_Test_Mobile_Application

fileprivate extension Item {
    init(param: Int) {
        self.init(
            text: "text-\(param)",
            confidence: Double(param),
            image: "image-\(param)",
            id: "id-\(param)")
    }
}

enum ItemsListPresenterTestError: Error {
    case testError
}

final class ItemsListPresenterTest: XCTestCase {

    var presenter: ItemsListPresenter!
    var model: ItemsListModelProtocolMock!
    var view: ItemsListViewProtocolMock!
    var router: RouterProtocolMock!

    @MainActor override func setUpWithError() throws {
        model = ItemsListModelProtocolMock()
        router = RouterProtocolMock()
        view = ItemsListViewProtocolMock()
        
        presenter = ItemsListPresenter(model: model, router: router)
        presenter.inject(view: view)
    }

    override func tearDownWithError() throws {
        view = nil
        model = nil
        router = nil
        presenter = nil
    }

    @MainActor func testLoadView() throws {
        model.items = (0...10).map { Item(text: "text-\($0)",
                                          confidence: Double($0),
                                          image: "image-\($0)",
                                          id: "id-\($0)") }
        presenter.loadView()
        XCTAssertEqual(model.injectPresenterItemsListPresenterProtocolVoidCallsCount, 1)
        XCTAssertEqual(model.tryLoadMoreItemVoidCallsCount, 1)
        XCTAssertEqual(presenter.itemCount, 11)
        XCTAssertEqual(presenter.item(10).id, "id-10")
        XCTAssertEqual(presenter.item(1).image, "image-1")
        XCTAssertEqual(presenter.item(3).text, "text-3")
        XCTAssertEqual(presenter.item(8).confidence, Double(8))
    }

    @MainActor func testClose() throws {
        model.items = (0...10).map { Item(text: "text-\($0)",
                                          confidence: Double($0),
                                          image: "image-\($0)",
                                          id: "id-\($0)") }

        XCTAssertEqual(router.showItemDetailsItemItemVoidCallsCount, 0)
        presenter.itemCellTouched(index: 8)
        XCTAssertEqual(router.showItemDetailsItemItemVoidReceivedItem?.id, "id-8")
    }

    @MainActor func testViewProgress() throws {
        XCTAssertFalse(view.showActivityIndicatorVoidCalled)
        XCTAssertFalse(view.hideActivityIndicatorVoidCalled)
        XCTAssertFalse(view.updateTableVoidCalled)

        presenter.startProgress()
        
        XCTAssertEqual(view.showActivityIndicatorVoidCallsCount, 1)

        presenter.stopProgress()

        XCTAssertEqual(view.hideActivityIndicatorVoidCallsCount, 1)

        presenter.newItemsLoaded()

        XCTAssertEqual(view.showActivityIndicatorVoidCallsCount, 1)
        XCTAssertEqual(view.hideActivityIndicatorVoidCallsCount, 2)
        XCTAssertEqual(view.updateTableVoidCallsCount, 1)
    }

    @MainActor func testModelProgressCanFetchNotInProgress() throws {

        model.canFetchMore = true
        model.inProgress = false

        XCTAssertFalse(model.tryLoadMoreItemVoidCalled)
        XCTAssertFalse(view.showActivityIndicatorVoidCalled)
        XCTAssertFalse(view.hideActivityIndicatorVoidCalled)

        presenter.onBottomScroll()

        XCTAssertEqual(model.tryLoadMoreItemVoidCallsCount, 1)
        XCTAssertEqual(view.hideActivityIndicatorVoidCallsCount, 0)
        XCTAssertEqual(view.showActivityIndicatorVoidCallsCount, 0)
    }

    @MainActor func testModelProgressCanFetchInProgress() throws {

        model.canFetchMore = true
        model.inProgress = true

        XCTAssertFalse(model.tryLoadMoreItemVoidCalled)
        XCTAssertFalse(view.showActivityIndicatorVoidCalled)
        XCTAssertFalse(view.hideActivityIndicatorVoidCalled)

        presenter.onBottomScroll()

        XCTAssertEqual(model.tryLoadMoreItemVoidCallsCount, 0)
        XCTAssertEqual(view.hideActivityIndicatorVoidCallsCount, 0)
        XCTAssertEqual(view.showActivityIndicatorVoidCallsCount, 0)
    }

    @MainActor func testModelProgressCannotFetchInProgress() throws {

        model.canFetchMore = false
        model.inProgress = true

        XCTAssertFalse(model.tryLoadMoreItemVoidCalled)
        XCTAssertFalse(view.showActivityIndicatorVoidCalled)
        XCTAssertFalse(view.hideActivityIndicatorVoidCalled)

        presenter.onBottomScroll()

        XCTAssertEqual(model.tryLoadMoreItemVoidCallsCount, 0)
        XCTAssertEqual(view.hideActivityIndicatorVoidCallsCount, 1)
        XCTAssertEqual(view.showActivityIndicatorVoidCallsCount, 0)
    }

    @MainActor func testModelProgressCannotFetchNotInProgress() throws {

        model.canFetchMore = false
        model.inProgress = false

        XCTAssertFalse(model.tryLoadMoreItemVoidCalled)
        XCTAssertFalse(view.showActivityIndicatorVoidCalled)
        XCTAssertFalse(view.hideActivityIndicatorVoidCalled)

        presenter.onBottomScroll()

        XCTAssertEqual(model.tryLoadMoreItemVoidCallsCount, 0)
        XCTAssertEqual(view.hideActivityIndicatorVoidCallsCount, 1)
        XCTAssertEqual(view.showActivityIndicatorVoidCallsCount, 0)
    }

    @MainActor func testError() {
        presenter.handle(error: ItemsListPresenterTestError.testError)
        XCTAssertEqual(router.showAlertErrorErrorVoidReceivedError as? ItemsListPresenterTestError, ItemsListPresenterTestError.testError)
    }
}
