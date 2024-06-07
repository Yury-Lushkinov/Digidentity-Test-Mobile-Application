//
//  ItemDetailsPresenterTest.swift
//  Digidentity-Test-Mobile-ApplicationTests
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import XCTest
@testable import Digidentity_Test_Mobile_Application

enum ItemDetailsPresenterTestError: Error {
    case testError
}

final class ItemDetailsPresenterTest: XCTestCase {
    var presenter: ItemDetailsPresenter!
    var model: ItemDetailsModelProtocolMock!
    var view: ItemDetailsViewProtocolMock!
    var router: RouterProtocolMock!

    override func setUpWithError() throws {
        model = ItemDetailsModelProtocolMock()
        router = RouterProtocolMock()
        view = ItemDetailsViewProtocolMock()

        presenter = ItemDetailsPresenter(model: model, router: router)
        presenter.inject(view: view)
    }

    override func tearDownWithError() throws {
        model = nil
        view = nil
        router = nil
        presenter = nil
    }

    func testLoadView() {
        XCTAssertIdentical(model.injectPresenterItemDetailsModelPresenterProtocolVoidReceivedPresenter, presenter)

        model.item = Item(text: "Item text", confidence: 9.0, image: "image url", id: "detailedid")
        let image = UIImage()
        model.imageUrlStringUIImageReturnValue = image

        presenter.loadView()

        XCTAssertEqual(view.setDetailsTextStringVoidReceivedText, "ID: detailedid\nConfidence: 9.0\nImage: image url")
        XCTAssertEqual(view.setTitleTextStringVoidReceivedText, "Item text")
        XCTAssertIdentical(view.setImageImageUIImageVoidReceivedImage, image)
    }

    func testClose() {
        XCTAssertEqual(router.backVoidCallsCount, 0)
        presenter.close()
        XCTAssertEqual(router.backVoidCallsCount, 1)
    }

    @MainActor func testError() {
        presenter.handle(error: ItemDetailsPresenterTestError.testError)
        XCTAssertEqual(router.showAlertErrorErrorVoidReceivedError as? ItemDetailsPresenterTestError, ItemDetailsPresenterTestError.testError)
    }
}
