//
//  File.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 05.06.2024.
//

import Foundation

struct Item: Sendable {
    init(text: String, confidence: Double, image: String, id: String) {
        self.text = text
        self.confidence = confidence
        self.image = image
        self.id = id
    }

    let text: String
    let confidence: Double
    let image: String
    let id: String
}
