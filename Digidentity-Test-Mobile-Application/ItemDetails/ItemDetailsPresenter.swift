//
//  ItemDetailsPresenter.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import Foundation
import UIKit

protocol ItemDetailsViewPresenterProtocol: AnyObject {
    func inject(view: ItemDetailsViewProtocol)
    func loadView()
    func close()
}

// sourcery: AutoMockable
protocol ItemDetailsModelPresenterProtocol: AnyObject {
    @MainActor func setImage(_ image: UIImage)
    @MainActor func handle(error: Error)
}

final class ItemDetailsPresenter {
    private let model: ItemDetailsModelProtocol
    private let router: RouterProtocol
    private weak var view: ItemDetailsViewProtocol!

    init(model: ItemDetailsModelProtocol, router: RouterProtocol) {
        self.model = model
        self.router = router

        model.inject(presenter: self)
    }
}

extension ItemDetailsPresenter: ItemDetailsViewPresenterProtocol {
    func inject(view: any ItemDetailsViewProtocol) {
        self.view = view
    }
    
    func loadView() {
        let item = model.item
        view.setDetails("ID: \(item.id)\nConfidence: \(item.confidence)\nImage: \(item.image)")
        view.setTitle(item.text)
        view.setImage(model.image(item.image))
    }

    func close() {
        router.back()
    }
}

extension ItemDetailsPresenter: ItemDetailsModelPresenterProtocol {
    func setImage(_ image: UIImage) {
        view.setImage(image)
    }

    func handle(error: any Error) {
        router.showAlert(error: error)
    }
}
