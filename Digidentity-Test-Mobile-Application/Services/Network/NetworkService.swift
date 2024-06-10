//
//  File.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 04.06.2024.
//

import Foundation

private struct ItemResponce: Codable {
    enum CodingKeys: String, CodingKey {
        case text
        case confidence
        case image
        case id = "_id"
    }

    let text: String
    let confidence: Double
    let image: String
    let id: String
}

private extension Item {
    init(responce: ItemResponce) {
        text = responce.text
        confidence = responce.confidence
        image = responce.image
        id = responce.id
    }
}

// sourcery: AutoMockable
protocol NetworkServiceProtocol {
    func fetchItems() async throws -> [Item]
    func fetchItems(sinceID: String?, maxID: String?) async throws -> [Item]
}

class NetworkService: NetworkServiceProtocol {
    let url = URL(string: "https://marlove.net/e/mock/v1/items")!
    let requestService: RequestServiceProtocol

    init(requestService: RequestServiceProtocol) {
        self.requestService = requestService
    }

    func fetchItems() async throws -> [Item] {
        return try await fetchServerItems()
    }

    func fetchItems(sinceID: String?, maxID: String?) async throws -> [Item] {
        return try await fetchServerItems(sinceID: sinceID, maxID: maxID)
    }

    private func fetchServerItems(sinceID: String? = nil, maxID: String? = nil) async throws -> [Item] {
        var url = self.url
        if let sinceID = sinceID {
            url.append(queryItems: [URLQueryItem(name: "since_id", value: sinceID)])
        }
        if let maxID = maxID {
            url.append(queryItems: [URLQueryItem(name: "max_id", value: maxID)])
        }
        var request = URLRequest(url: url)
        request.addValue("d3faa4b140a2e42f43a06cab0d69602b", forHTTPHeaderField: "Authorization")

        let responce: [ItemResponce] = try await requestService.send(request: request)

        return responce.map { Item(responce: $0) }
    }
}
