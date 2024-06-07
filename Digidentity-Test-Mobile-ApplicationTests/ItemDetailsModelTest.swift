//
//  ItemDetailsModelTest.swift
//  Digidentity-Test-Mobile-ApplicationTests
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import XCTest
@testable import Digidentity_Test_Mobile_Application

enum ItemDetailsModelTestError: Error {
    case modelError
}

final class ItemDetailsModelTest: XCTestCase {
    var model: ItemDetailsModel!

    var presenter: ItemDetailsModelPresenterProtocolMock!
    var view: ItemDetailsViewProtocolMock!
    var imageCache: ImageStorageProtocolMock!
    var item: Item!

    override func setUpWithError() throws {
        view = ItemDetailsViewProtocolMock()
        presenter = ItemDetailsModelPresenterProtocolMock()
        imageCache = ImageStorageProtocolMock()

        item = Item(text: "detaled text",
                    confidence: 3.4,
                    image: "detailed image",
                    id: "detailed id")
        model = ItemDetailsModel(item: item, imageCache: imageCache)
        model.inject(presenter: presenter)
    }

    override func tearDownWithError() throws {
        model = nil
        view = nil
        imageCache = nil
        presenter = nil
    }

    func testItem() throws {
        XCTAssertEqual(item.id, model.item.id)
        XCTAssertEqual(item.confidence, model.item.confidence)
        XCTAssertEqual(item.text, model.item.text)
        XCTAssertEqual(item.image, model.item.image)
    }

    func testImageDowloading() throws {
        let downloadedImage = UIImage()
        imageCache.cachedImageUrlStringUIImageReturnValue = nil
        imageCache.loadImageUrlStringUIImageReturnValue = downloadedImage
        let image = model.image("test image url")

        let placeHolderImage = UIImage(named: "loading")!

        XCTAssertTrue(imageCache.cachedImageUrlStringUIImageCalled)
        XCTAssertTrue(imageCache.loadImageUrlStringUIImageCalled)
        XCTAssertIdentical(image, placeHolderImage)
    }

    func testImageFromCache() throws {
        let cachedImage = UIImage()
        imageCache.cachedImageUrlStringUIImageReturnValue = cachedImage
        imageCache.loadImageUrlStringUIImageReturnValue = UIImage()
        let image = model.image("test image url")

        XCTAssertIdentical(image, cachedImage)
        XCTAssertFalse(imageCache.loadImageUrlStringUIImageCalled)
    }

    func testError() {
        let loadImageExpectaion = XCTestExpectation(description: "Wait await imageCache.loadImage(url: url)")
        let handleErrorExpectaion = XCTestExpectation(description: "Wait await presenter.handle(error: error))")
        let updateImageExpectaion = XCTestExpectation(description: "Wait await presenter.update(image: image, url: url)")

        imageCache.loadImageUrlStringUIImageClosure = { url throws in
            defer {
                loadImageExpectaion.fulfill()
            }
            XCTAssertEqual("test-error-image-url", url)
            throw ItemDetailsModelTestError.modelError
        }

        presenter.handleErrorErrorVoidClosure = { _ in
            handleErrorExpectaion.fulfill()
        }

        presenter.setImageImageUIImageVoidClosure = { _ in
            updateImageExpectaion.fulfill()
        }

        let image = model.image("test-error-image-url")
        XCTAssertIdentical(image, UIImage(named: "loading"))

        wait(for: [loadImageExpectaion, updateImageExpectaion, ], timeout: 1.0)
        XCTAssertEqual(presenter.handleErrorErrorVoidReceivedError as? ItemDetailsModelTestError, ItemDetailsModelTestError.modelError)
        XCTAssertIdentical(presenter.setImageImageUIImageVoidReceivedImage, UIImage(named: "LoadingError"))

    }
}
