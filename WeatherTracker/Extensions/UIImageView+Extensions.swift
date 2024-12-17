//
//  UIImageView+Extensions.swift
//  WeatherTracker
//
//  Created by 方敏起 on 12/15/24.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error {
                print("Error loading image: \(error.localizedDescription)")
            }
            if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
               }
            }
        }.resume()
        
    }
}
