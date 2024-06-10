// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

@testable import Digidntity_Test_Mobile_Application
























class ImageStorageProtocolMock: ImageStorageProtocol {




    //MARK: - loadImage

    var loadImageUrlStringUIImageThrowableError: (any Error)?
    var loadImageUrlStringUIImageCallsCount = 0
    var loadImageUrlStringUIImageCalled: Bool {
        return loadImageUrlStringUIImageCallsCount > 0
    }
    var loadImageUrlStringUIImageReceivedUrl: (String)?
    var loadImageUrlStringUIImageReceivedInvocations: [(String)] = []
    var loadImageUrlStringUIImageReturnValue: UIImage!
    var loadImageUrlStringUIImageClosure: ((String) async throws -> UIImage)?

    func loadImage(url: String) async throws -> UIImage {
        loadImageUrlStringUIImageCallsCount += 1
        loadImageUrlStringUIImageReceivedUrl = url
        loadImageUrlStringUIImageReceivedInvocations.append(url)
        if let error = loadImageUrlStringUIImageThrowableError {
            throw error
        }
        if let loadImageUrlStringUIImageClosure = loadImageUrlStringUIImageClosure {
            return try await loadImageUrlStringUIImageClosure(url)
        } else {
            return loadImageUrlStringUIImageReturnValue
        }
    }

    //MARK: - cachedImage

    var cachedImageUrlStringUIImageCallsCount = 0
    var cachedImageUrlStringUIImageCalled: Bool {
        return cachedImageUrlStringUIImageCallsCount > 0
    }
    var cachedImageUrlStringUIImageReceivedUrl: (String)?
    var cachedImageUrlStringUIImageReceivedInvocations: [(String)] = []
    var cachedImageUrlStringUIImageReturnValue: UIImage?
    var cachedImageUrlStringUIImageClosure: ((String) -> UIImage?)?

    func cachedImage(url: String) -> UIImage? {
        cachedImageUrlStringUIImageCallsCount += 1
        cachedImageUrlStringUIImageReceivedUrl = url
        cachedImageUrlStringUIImageReceivedInvocations.append(url)
        if let cachedImageUrlStringUIImageClosure = cachedImageUrlStringUIImageClosure {
            return cachedImageUrlStringUIImageClosure(url)
        } else {
            return cachedImageUrlStringUIImageReturnValue
        }
    }


}
class ItemDetailsModelPresenterProtocolMock: ItemDetailsModelPresenterProtocol {




    //MARK: - setImage

    var setImageImageUIImageVoidCallsCount = 0
    var setImageImageUIImageVoidCalled: Bool {
        return setImageImageUIImageVoidCallsCount > 0
    }
    var setImageImageUIImageVoidReceivedImage: (UIImage)?
    var setImageImageUIImageVoidReceivedInvocations: [(UIImage)] = []
    var setImageImageUIImageVoidClosure: ((UIImage) -> Void)?

    @MainActor
    func setImage(_ image: UIImage) {
        setImageImageUIImageVoidCallsCount += 1
        setImageImageUIImageVoidReceivedImage = image
        setImageImageUIImageVoidReceivedInvocations.append(image)
        setImageImageUIImageVoidClosure?(image)
    }

    //MARK: - handle

    var handleErrorErrorVoidCallsCount = 0
    var handleErrorErrorVoidCalled: Bool {
        return handleErrorErrorVoidCallsCount > 0
    }
    var handleErrorErrorVoidReceivedError: (Error)?
    var handleErrorErrorVoidReceivedInvocations: [(Error)] = []
    var handleErrorErrorVoidClosure: ((Error) -> Void)?

    @MainActor
    func handle(error: Error) {
        handleErrorErrorVoidCallsCount += 1
        handleErrorErrorVoidReceivedError = error
        handleErrorErrorVoidReceivedInvocations.append(error)
        handleErrorErrorVoidClosure?(error)
    }


}
class ItemDetailsModelProtocolMock: ItemDetailsModelProtocol {


    var item: Item {
        get { return underlyingItem }
        set(value) { underlyingItem = value }
    }
    var underlyingItem: (Item)!


    //MARK: - inject

    var injectPresenterItemDetailsModelPresenterProtocolVoidCallsCount = 0
    var injectPresenterItemDetailsModelPresenterProtocolVoidCalled: Bool {
        return injectPresenterItemDetailsModelPresenterProtocolVoidCallsCount > 0
    }
    var injectPresenterItemDetailsModelPresenterProtocolVoidReceivedPresenter: (ItemDetailsModelPresenterProtocol)?
    var injectPresenterItemDetailsModelPresenterProtocolVoidReceivedInvocations: [(ItemDetailsModelPresenterProtocol)] = []
    var injectPresenterItemDetailsModelPresenterProtocolVoidClosure: ((ItemDetailsModelPresenterProtocol) -> Void)?

    func inject(presenter: ItemDetailsModelPresenterProtocol) {
        injectPresenterItemDetailsModelPresenterProtocolVoidCallsCount += 1
        injectPresenterItemDetailsModelPresenterProtocolVoidReceivedPresenter = presenter
        injectPresenterItemDetailsModelPresenterProtocolVoidReceivedInvocations.append(presenter)
        injectPresenterItemDetailsModelPresenterProtocolVoidClosure?(presenter)
    }

    //MARK: - image

    var imageUrlStringUIImageCallsCount = 0
    var imageUrlStringUIImageCalled: Bool {
        return imageUrlStringUIImageCallsCount > 0
    }
    var imageUrlStringUIImageReceivedUrl: (String)?
    var imageUrlStringUIImageReceivedInvocations: [(String)] = []
    var imageUrlStringUIImageReturnValue: UIImage!
    var imageUrlStringUIImageClosure: ((String) -> UIImage)?

    func image(_ url: String) -> UIImage {
        imageUrlStringUIImageCallsCount += 1
        imageUrlStringUIImageReceivedUrl = url
        imageUrlStringUIImageReceivedInvocations.append(url)
        if let imageUrlStringUIImageClosure = imageUrlStringUIImageClosure {
            return imageUrlStringUIImageClosure(url)
        } else {
            return imageUrlStringUIImageReturnValue
        }
    }


}
class ItemDetailsViewProtocolMock: ItemDetailsViewProtocol {




    //MARK: - setImage

    var setImageImageUIImageVoidCallsCount = 0
    var setImageImageUIImageVoidCalled: Bool {
        return setImageImageUIImageVoidCallsCount > 0
    }
    var setImageImageUIImageVoidReceivedImage: (UIImage)?
    var setImageImageUIImageVoidReceivedInvocations: [(UIImage)] = []
    var setImageImageUIImageVoidClosure: ((UIImage) -> Void)?

    func setImage(_ image: UIImage) {
        setImageImageUIImageVoidCallsCount += 1
        setImageImageUIImageVoidReceivedImage = image
        setImageImageUIImageVoidReceivedInvocations.append(image)
        setImageImageUIImageVoidClosure?(image)
    }

    //MARK: - setTitle

    var setTitleTextStringVoidCallsCount = 0
    var setTitleTextStringVoidCalled: Bool {
        return setTitleTextStringVoidCallsCount > 0
    }
    var setTitleTextStringVoidReceivedText: (String)?
    var setTitleTextStringVoidReceivedInvocations: [(String)] = []
    var setTitleTextStringVoidClosure: ((String) -> Void)?

    func setTitle(_ text: String) {
        setTitleTextStringVoidCallsCount += 1
        setTitleTextStringVoidReceivedText = text
        setTitleTextStringVoidReceivedInvocations.append(text)
        setTitleTextStringVoidClosure?(text)
    }

    //MARK: - setDetails

    var setDetailsTextStringVoidCallsCount = 0
    var setDetailsTextStringVoidCalled: Bool {
        return setDetailsTextStringVoidCallsCount > 0
    }
    var setDetailsTextStringVoidReceivedText: (String)?
    var setDetailsTextStringVoidReceivedInvocations: [(String)] = []
    var setDetailsTextStringVoidClosure: ((String) -> Void)?

    func setDetails(_ text: String) {
        setDetailsTextStringVoidCallsCount += 1
        setDetailsTextStringVoidReceivedText = text
        setDetailsTextStringVoidReceivedInvocations.append(text)
        setDetailsTextStringVoidClosure?(text)
    }


}
class ItemsListModelProtocolMock: ItemsListModelProtocol {


    var items: [Item] = []
    var canFetchMore: Bool {
        get { return underlyingCanFetchMore }
        set(value) { underlyingCanFetchMore = value }
    }
    var underlyingCanFetchMore: (Bool)!
    var inProgress: Bool {
        get { return underlyingInProgress }
        set(value) { underlyingInProgress = value }
    }
    var underlyingInProgress: (Bool)!


    //MARK: - inject

    var injectPresenterItemsListPresenterProtocolVoidCallsCount = 0
    var injectPresenterItemsListPresenterProtocolVoidCalled: Bool {
        return injectPresenterItemsListPresenterProtocolVoidCallsCount > 0
    }
    var injectPresenterItemsListPresenterProtocolVoidReceivedPresenter: (ItemsListPresenterProtocol)?
    var injectPresenterItemsListPresenterProtocolVoidReceivedInvocations: [(ItemsListPresenterProtocol)] = []
    var injectPresenterItemsListPresenterProtocolVoidClosure: ((ItemsListPresenterProtocol) -> Void)?

    func inject(presenter: ItemsListPresenterProtocol) {
        injectPresenterItemsListPresenterProtocolVoidCallsCount += 1
        injectPresenterItemsListPresenterProtocolVoidReceivedPresenter = presenter
        injectPresenterItemsListPresenterProtocolVoidReceivedInvocations.append(presenter)
        injectPresenterItemsListPresenterProtocolVoidClosure?(presenter)
    }

    //MARK: - tryLoadMoreItem

    var tryLoadMoreItemVoidCallsCount = 0
    var tryLoadMoreItemVoidCalled: Bool {
        return tryLoadMoreItemVoidCallsCount > 0
    }
    var tryLoadMoreItemVoidClosure: (() -> Void)?

    func tryLoadMoreItem() {
        tryLoadMoreItemVoidCallsCount += 1
        tryLoadMoreItemVoidClosure?()
    }

    //MARK: - image

    var imageUrlStringUIImageCallsCount = 0
    var imageUrlStringUIImageCalled: Bool {
        return imageUrlStringUIImageCallsCount > 0
    }
    var imageUrlStringUIImageReceivedUrl: (String)?
    var imageUrlStringUIImageReceivedInvocations: [(String)] = []
    var imageUrlStringUIImageReturnValue: UIImage!
    var imageUrlStringUIImageClosure: ((String) -> UIImage)?

    func image(_ url: String) -> UIImage {
        imageUrlStringUIImageCallsCount += 1
        imageUrlStringUIImageReceivedUrl = url
        imageUrlStringUIImageReceivedInvocations.append(url)
        if let imageUrlStringUIImageClosure = imageUrlStringUIImageClosure {
            return imageUrlStringUIImageClosure(url)
        } else {
            return imageUrlStringUIImageReturnValue
        }
    }


}
class ItemsListViewProtocolMock: ItemsListViewProtocol {




    //MARK: - updateTable

    var updateTableVoidCallsCount = 0
    var updateTableVoidCalled: Bool {
        return updateTableVoidCallsCount > 0
    }
    var updateTableVoidClosure: (() -> Void)?

    func updateTable() {
        updateTableVoidCallsCount += 1
        updateTableVoidClosure?()
    }

    //MARK: - imageForCell

    var imageForCellIndexIntImageUIImageVoidCallsCount = 0
    var imageForCellIndexIntImageUIImageVoidCalled: Bool {
        return imageForCellIndexIntImageUIImageVoidCallsCount > 0
    }
    var imageForCellIndexIntImageUIImageVoidReceivedArguments: (index: Int, image: UIImage)?
    var imageForCellIndexIntImageUIImageVoidReceivedInvocations: [(index: Int, image: UIImage)] = []
    var imageForCellIndexIntImageUIImageVoidClosure: ((Int, UIImage) -> Void)?

    func imageForCell(index: Int, image: UIImage) {
        imageForCellIndexIntImageUIImageVoidCallsCount += 1
        imageForCellIndexIntImageUIImageVoidReceivedArguments = (index: index, image: image)
        imageForCellIndexIntImageUIImageVoidReceivedInvocations.append((index: index, image: image))
        imageForCellIndexIntImageUIImageVoidClosure?(index, image)
    }

    //MARK: - showActivityIndicator

    var showActivityIndicatorVoidCallsCount = 0
    var showActivityIndicatorVoidCalled: Bool {
        return showActivityIndicatorVoidCallsCount > 0
    }
    var showActivityIndicatorVoidClosure: (() -> Void)?

    func showActivityIndicator() {
        showActivityIndicatorVoidCallsCount += 1
        showActivityIndicatorVoidClosure?()
    }

    //MARK: - hideActivityIndicator

    var hideActivityIndicatorVoidCallsCount = 0
    var hideActivityIndicatorVoidCalled: Bool {
        return hideActivityIndicatorVoidCallsCount > 0
    }
    var hideActivityIndicatorVoidClosure: (() -> Void)?

    func hideActivityIndicator() {
        hideActivityIndicatorVoidCallsCount += 1
        hideActivityIndicatorVoidClosure?()
    }


}
class NetworkServiceProtocolMock: NetworkServiceProtocol {




    //MARK: - fetchItems

    var fetchItemsItemThrowableError: (any Error)?
    var fetchItemsItemCallsCount = 0
    var fetchItemsItemCalled: Bool {
        return fetchItemsItemCallsCount > 0
    }
    var fetchItemsItemReturnValue: [Item]!
    var fetchItemsItemClosure: (() async throws -> [Item])?

    func fetchItems() async throws -> [Item] {
        fetchItemsItemCallsCount += 1
        if let error = fetchItemsItemThrowableError {
            throw error
        }
        if let fetchItemsItemClosure = fetchItemsItemClosure {
            return try await fetchItemsItemClosure()
        } else {
            return fetchItemsItemReturnValue
        }
    }

    //MARK: - fetchItems

    var fetchItemsSinceIDStringMaxIDStringItemThrowableError: (any Error)?
    var fetchItemsSinceIDStringMaxIDStringItemCallsCount = 0
    var fetchItemsSinceIDStringMaxIDStringItemCalled: Bool {
        return fetchItemsSinceIDStringMaxIDStringItemCallsCount > 0
    }
    var fetchItemsSinceIDStringMaxIDStringItemReceivedArguments: (sinceID: String?, maxID: String?)?
    var fetchItemsSinceIDStringMaxIDStringItemReceivedInvocations: [(sinceID: String?, maxID: String?)] = []
    var fetchItemsSinceIDStringMaxIDStringItemReturnValue: [Item]!
    var fetchItemsSinceIDStringMaxIDStringItemClosure: ((String?, String?) async throws -> [Item])?

    func fetchItems(sinceID: String?, maxID: String?) async throws -> [Item] {
        fetchItemsSinceIDStringMaxIDStringItemCallsCount += 1
        fetchItemsSinceIDStringMaxIDStringItemReceivedArguments = (sinceID: sinceID, maxID: maxID)
        fetchItemsSinceIDStringMaxIDStringItemReceivedInvocations.append((sinceID: sinceID, maxID: maxID))
        if let error = fetchItemsSinceIDStringMaxIDStringItemThrowableError {
            throw error
        }
        if let fetchItemsSinceIDStringMaxIDStringItemClosure = fetchItemsSinceIDStringMaxIDStringItemClosure {
            return try await fetchItemsSinceIDStringMaxIDStringItemClosure(sinceID, maxID)
        } else {
            return fetchItemsSinceIDStringMaxIDStringItemReturnValue
        }
    }


}
class RequestServiceProtocolMock: RequestServiceProtocol {




    //MARK: - send<Responce: Decodable>

    var sendResponceDecodableRequestURLRequestResponceThrowableError: (any Error)?
    var sendResponceDecodableRequestURLRequestResponceCallsCount = 0
    var sendResponceDecodableRequestURLRequestResponceCalled: Bool {
        return sendResponceDecodableRequestURLRequestResponceCallsCount > 0
    }
    var sendResponceDecodableRequestURLRequestResponceReceivedRequest: (URLRequest)?
    var sendResponceDecodableRequestURLRequestResponceReceivedInvocations: [(URLRequest)] = []
    var sendResponceDecodableRequestURLRequestResponceReturnValue: Responce!
    var sendResponceDecodableRequestURLRequestResponceClosure: ((URLRequest) async throws -> Responce)?

    func send<Responce: Decodable>(request: URLRequest) async throws -> Responce {
        sendResponceDecodableRequestURLRequestResponceCallsCount += 1
        sendResponceDecodableRequestURLRequestResponceReceivedRequest = request
        sendResponceDecodableRequestURLRequestResponceReceivedInvocations.append(request)
        if let error = sendResponceDecodableRequestURLRequestResponceThrowableError {
            throw error
        }
        if let sendResponceDecodableRequestURLRequestResponceClosure = sendResponceDecodableRequestURLRequestResponceClosure {
            return try await sendResponceDecodableRequestURLRequestResponceClosure(request)
        } else {
            return sendResponceDecodableRequestURLRequestResponceReturnValue
        }
    }


}
class RouterProtocolMock: RouterProtocol {




    //MARK: - showItemDetails

    var showItemDetailsItemItemVoidCallsCount = 0
    var showItemDetailsItemItemVoidCalled: Bool {
        return showItemDetailsItemItemVoidCallsCount > 0
    }
    var showItemDetailsItemItemVoidReceivedItem: (Item)?
    var showItemDetailsItemItemVoidReceivedInvocations: [(Item)] = []
    var showItemDetailsItemItemVoidClosure: ((Item) -> Void)?

    func showItemDetails(_ item: Item) {
        showItemDetailsItemItemVoidCallsCount += 1
        showItemDetailsItemItemVoidReceivedItem = item
        showItemDetailsItemItemVoidReceivedInvocations.append(item)
        showItemDetailsItemItemVoidClosure?(item)
    }

    //MARK: - back

    var backVoidCallsCount = 0
    var backVoidCalled: Bool {
        return backVoidCallsCount > 0
    }
    var backVoidClosure: (() -> Void)?

    func back() {
        backVoidCallsCount += 1
        backVoidClosure?()
    }

    //MARK: - showAlert

    var showAlertErrorErrorVoidCallsCount = 0
    var showAlertErrorErrorVoidCalled: Bool {
        return showAlertErrorErrorVoidCallsCount > 0
    }
    var showAlertErrorErrorVoidReceivedError: (Error)?
    var showAlertErrorErrorVoidReceivedInvocations: [(Error)] = []
    var showAlertErrorErrorVoidClosure: ((Error) -> Void)?

    func showAlert(error: Error) {
        showAlertErrorErrorVoidCallsCount += 1
        showAlertErrorErrorVoidReceivedError = error
        showAlertErrorErrorVoidReceivedInvocations.append(error)
        showAlertErrorErrorVoidClosure?(error)
    }


}
