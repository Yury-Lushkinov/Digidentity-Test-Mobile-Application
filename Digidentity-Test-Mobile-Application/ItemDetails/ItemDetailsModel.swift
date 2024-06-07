//
//  ItemDetailsModel.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import Foundation
import UIKit


// sourcery: AutoMockable
protocol ItemDetailsModelProtocol {
    var item: Item { get }
    func inject(presenter: ItemDetailsModelPresenterProtocol)
    func image(_ url: String) -> UIImage
}


class ItemDetailsModel: ItemDetailsModelProtocol {
    private weak var presenter: ItemDetailsModelPresenterProtocol!
    private let imageCache: ImageStorageProtocol
    let item: Item

    init(item: Item, imageCache: ImageStorageProtocol) {
        self.item = item
        self.imageCache = imageCache
    }

    func inject(presenter: any ItemDetailsModelPresenterProtocol) {
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
                await presenter.setImage(image)
            }
        }

        return UIImage(named: "loading")!
    }
}
