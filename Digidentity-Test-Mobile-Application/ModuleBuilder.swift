//
//  ModuleBuilder.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import Foundation

protocol ModuleBuilderProtocol {
    func createItemsList(services: ServiceHolderProtocol, router: RouterProtocol) -> ItemsListViewController
    func createItemDetails(services: ServiceHolderProtocol, router: RouterProtocol, item: Item) -> ItemDetailsViewController
}

final class ModuleBuilder: ModuleBuilderProtocol {
    func createItemsList(services: ServiceHolderProtocol, router: RouterProtocol) -> ItemsListViewController {
        let model = ItemsListModel(network: services.networkService, storage: services.dataStorage)
        let presenter = ItemsListPresenter(model: model, router: router)
        let view = ItemsListViewController(presenter: presenter)

        return view
    }

    func createItemDetails(services: ServiceHolderProtocol, router: RouterProtocol, item: Item) -> ItemDetailsViewController {
        let model = ItemDetailsModel(item: item, imageCache: services.imageStorage)
        let presenter = ItemDetailsPresenter(model: model, router: router)
        let view = ItemDetailsViewController(presenter: presenter)

        return view
    }
}
