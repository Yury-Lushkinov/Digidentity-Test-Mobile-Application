//
//  ImageStorage.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import Foundation
import UIKit

enum ImageStorageError: Error {
    case invalidUrlString(String)
    case wrongImageData
}

// sourcery: AutoMockable
protocol ImageStorageProtocol {
    func loadImage(url: String) async throws -> UIImage
    func cachedImage(url: String) -> UIImage?
}

class ImageStorage: ImageStorageProtocol {
    let cache: URLCache

    init() {
        let memoryCapacity = 4 * 1024 * 1024
        let diskCapacity = 50 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
        URLCache.shared = urlCache

        cache = urlCache
    }

    func cachedImage(url: String) -> UIImage? {
        guard let url = URL(string: url) else {
            return nil
        }

        let request = URLRequest(url: url)
        guard let cached = cache.cachedResponse(for: request) else {
            return nil
        }

        return UIImage(data: cached.data)
    }

    func loadImage(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else {
            throw ImageStorageError.invalidUrlString(url)
        }

        let request = URLRequest(url: url)
        let (data, responce) = try await URLSession.shared.data(for: request)

        if let httpResponse = responce as? HTTPURLResponse,
           httpResponse.statusCode == 200 {
            let cachedResponse = CachedURLResponse(response: httpResponse, data: data)
            cache.storeCachedResponse(cachedResponse, for: request)
        }

        guard let image = UIImage(data: data) else {
            throw ImageStorageError.wrongImageData
        }

        return image
    }
}
