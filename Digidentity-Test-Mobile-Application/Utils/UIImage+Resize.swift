//
//  UIImage+Resize.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 05.06.2024.
//

import UIKit

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
