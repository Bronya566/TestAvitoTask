//
//  ImageLoader.swift
//  AvitoTest
//
//  Created by Дмитрий on 29.08.2023.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func getImage(imageUrl: String, handler: @escaping (UIImage?) -> Void)
    func stop()
}

final class ImageLoader: ImageLoaderProtocol {
    private var imageTask: URLSessionDataTask?
    private let session = URLSession.shared
    
    func getImage(imageUrl: String, handler: @escaping (UIImage?) -> Void) {
        let url = URL(string: imageUrl)
        guard let url else {
            return
        }
        imageTask = session.dataTask(with: url) { (data, _, _) in
            guard let data else {
                return
            }
            handler(UIImage(data: data))
        }
        imageTask?.resume()
    }
    
    func stop() {
        imageTask?.cancel()
    }
}
