//
//  Router.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol RouterProtocol: AnyObject {
    func showItemDetails(_ item: Item)
    func back()
    func showAlert(error: Error)
}

final class Router: RouterProtocol {
    private let services: ServiceHolder
    private let builder: ModuleBuilderProtocol

    private lazy var navigationController: UINavigationController = {
        let itemsListViewController = builder.createItemsList(services: services, router: self)
        return UINavigationController(rootViewController: itemsListViewController)
    } ()

    var rootViewConroller: UIViewController {
        navigationController
    }

    init(services: ServiceHolder, builder: ModuleBuilderProtocol) {
        self.services = services
        self.builder = builder
    }

    func showItemDetails(_ item: Item) {
        let itemDetailsViewController = builder.createItemDetails(services: services, router: self, item: item)
        navigationController.pushViewController(itemDetailsViewController, animated: true)
    }

    func back() {
        navigationController.popViewController(animated: true)
    }

    func showAlert(error: any Error) {
        let alert = UIAlertController(title: "Failure",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close",
                                      style: .default,
                                      handler: nil))
        navigationController.present(alert, animated: true)
    }
}
