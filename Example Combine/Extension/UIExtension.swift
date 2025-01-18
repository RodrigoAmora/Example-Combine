//
//  UIExtension.swift
//  Example Combine
//
//  Created by Rodrigo Amora on 18/01/25.
//

import Foundation
import UIKit

extension UIImageView {
    func roundedCorners() {
        self.backgroundColor = .blue
        self.clipsToBounds = true
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func roundedImage() {
        self.roundedCorners()
        self.layer.cornerRadius = bounds.height / 5
    }
    
    func loadImageFromURL(_ url: String) {
        self.contentMode = .scaleToFill
        
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
