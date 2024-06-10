//
//  ServiceHolder.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 04.06.2024.
//

import Foundation

protocol ServiceHolderProtocol {
    var networkService: NetworkServiceProtocol { get }
    var dataStorage: DataStorageProtocol { get }
    var imageStorage: ImageStorageProtocol { get }
}

class ServiceHolder: ServiceHolderProtocol {
    let networkService: NetworkServiceProtocol = NetworkService(requestService: RequestService())
    let dataStorage: DataStorageProtocol = DataStorage()
    let imageStorage: ImageStorageProtocol = ImageStorage()
}


