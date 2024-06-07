//
//  ItemsListPresenter.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 04.06.2024.
//

import Foundation
import UIKit

typealias ItemsListPresenterProtocol = ItemsListViewPresenterProtocol & ItemsListModelPresenterProtocol

protocol ItemsListViewPresenterProtocol: AnyObject {
    func inject(view: ItemsListViewProtocol)
    @MainActor func item(_ index: Int) -> ItemInfoProtocol
    @MainActor var itemCount: Int { get }
    @MainActor func loadView()
    @MainActor func onBottomScroll()
    @MainActor func image(_ url: String) -> UIImage
    @MainActor func itemCellTouched(index: Int)
}

protocol ItemsListModelPresenterProtocol: AnyObject {
    @MainActor func newItemsLoaded()
    @MainActor func startProgress()
    @MainActor func stopProgress()
    @MainActor func update(image: UIImage, url: String)
    @MainActor func handle(error: any Error)
}

protocol ItemInfoProtocol {
    var text: String { get }
    var confidence: Double { get }
    var image: String { get }
    var id: String { get }
    var formatedDescription: String { get }
}

extension Item: ItemInfoProtocol {
    var formatedDescription: String {
        "ID: \(id)\nConfidence: \(confidence)\nImage: \(image)"
    }
}

class ItemsListPresenter {
    private let model: ItemsListModelProtocol
    private let router: RouterProtocol
    private weak var view: ItemsListViewProtocol!

    init(model: ItemsListModelProtocol, router: RouterProtocol) {
        self.model = model
        self.router = router

        model.inject(presenter: self)
    }
}

extension ItemsListPresenter: ItemsListModelPresenterProtocol {
    func update(image: UIImage, url: String) {
        guard let index = model.items.firstIndex(where: { $0.image == url }) else {
            return
        }

        view.imageForCell(index: index, image: image)
    }
    
    func startProgress() {
        view.showActivityIndicator()
    }
    
    func stopProgress() {
        view.hideActivityIndicator()
    }
    
    func newItemsLoaded() {
        view.hideActivityIndicator()
        view.updateTable()
    }

    func handle(error: any Error) {
        router.showAlert(error: error)
    }
}

extension ItemsListPresenter: ItemsListViewPresenterProtocol {
    func inject(view: any ItemsListViewProtocol) {
        self.view = view
    }
    
    func loadView() {
        model.tryLoadMoreItem()
    }
    
    func image(_ url: String) -> UIImage {
        return model.image(url)
    }
    
    func onBottomScroll() {
        if model.canFetchMore {
            guard !model.inProgress else {
                return
            }

            model.tryLoadMoreItem()
        } else {
            view.hideActivityIndicator()
        }
    }

    var itemCount: Int {
        model.items.count
    }

    func item(_ index: Int) -> any ItemInfoProtocol {
        return model.items[index]
    }

    func itemCellTouched(index: Int) {
        router.showItemDetails(model.items[index])
    }
}
