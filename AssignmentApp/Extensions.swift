//
//  Extensions.swift
//  TestApp
//
//  Created by Nayan Sayare on 17/06/22.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping() -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                completion()
            }
        }.resume()
    }
    
    func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping() -> Void) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode) {
            completion()
        }
    }
}

extension UIView {
    func applyShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.masksToBounds = false
    }
}

extension UIViewController {
    static func loadFromNib<T: UIViewController>(_: T.Type) -> T {
        return T.init(nibName: String(describing: T.self), bundle: nil)
    }
}
