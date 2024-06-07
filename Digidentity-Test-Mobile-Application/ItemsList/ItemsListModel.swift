//
//  ItemsListModel.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 04.06.2024.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol ItemsListModelProtocol: AnyObject {
    @MainActor var items: [Item] { get }
    @MainActor var canFetchMore: Bool { get }
    @MainActor var inProgress: Bool { get }
    func inject(presenter: ItemsListPresenterProtocol)
    func tryLoadMoreItem()
    func image(_ url: String) -> UIImage
}

final class ItemsListModel: ItemsListModelProtocol {
    struct Constants {
        static let itemsInResponce = 10
    }

    private let network: NetworkServiceProtocol
    private let storage: DataStorageProtocol
    private let imageCache = ImageStorage()
    private weak var presenter: ItemsListModelPresenterProtocol!

    @MainActor private(set) var items: [Item] = []
    @MainActor private(set) var canFetchMore = true
    @MainActor private(set) var inProgress = false

    init(network: NetworkServiceProtocol, storage: DataStorageProtocol) {
        self.network = network
        self.storage = storage
    }

    @MainActor private func update(items: [Item]) {
        self.items = items
        canFetchMore = !items.isEmpty

        presenter.newItemsLoaded()
    }

    @MainActor private func append(items: [Item]) {
        self.items.append(contentsOf: items)
        canFetchMore = !items.isEmpty

        presenter.newItemsLoaded()
    }

    @MainActor private func progress(start: Bool) {
        inProgress = start
    }

    func inject(presenter: ItemsListPresenterProtocol) {
        self.presenter = presenter
    }

    func image(_ url: String) -> UIImage {
        if let image = imageCache.cachedImage(url: url) {
            return image
        } else {
            Task {
                let image: UIImage
                do {
                    image = try await imageCache.loadImage(url: url)
                } catch {
                    await presenter.handle(error: error)
                    image = UIImage(named: "LoadingError")!
                }
                await presenter.update(image: image, url: url)
            }
        }

        return UIImage(named: "loading")!
    }

    func tryLoadMoreItem() {
        Task {
            await progress(start: true)
            do {
                if let last = await items.last {
                    let items = try await loadMoreItems(lastID: last.id)
                    await append(items: items)
                } else {
                    let items = try await loadFirstItems()
                    await update(items: items)
                }
            } catch {
                await presenter.handle(error: error)
            }
            await progress(start: false)
        }
    }

    private func loadFirstItems() async throws -> [Item] {
        var items = try await storage.fetchFirstItems(number: Constants.itemsInResponce)
        if items.isEmpty {
            items = try await network.fetchItems()
            try await storage.write(items: items)
        }

        return items
    }

    private func loadMoreItems(lastID: String) async throws -> [Item] {
        var items = try await storage.fetchNextItems(after: lastID, number: Constants.itemsInResponce)
        if items.isEmpty {
            items = try await network.fetchItems(sinceID: nil, maxID: lastID)
            try await storage.append(items: items)
        }

        return items
    }
}
