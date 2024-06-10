//
//  RequestService.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by  admin on 10.06.2024.
//

import Foundation

// sourcery: AutoMockable
protocol RequestServiceProtocol {
    func send<Responce: Decodable>(request: URLRequest) async throws -> Responce
}

final class RequestService: RequestServiceProtocol {
    func send<Responce: Decodable>(request: URLRequest) async throws -> Responce {
        let sessionResponce = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Responce.self, from: sessionResponce.0)
    }
}
