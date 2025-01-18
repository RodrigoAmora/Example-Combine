//
//  UIExtension.swift
//  Example Combine
//
//  Created by Rodrigo Amora on 18/01/25.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageFromURL(_ url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
