//
//  NetworkService.swift
//  AvitoTest
//
//  Created by Дмитрий on 29.08.2023.
//

import UIKit

protocol NetworkServiceProtocol {
    func getData(handler: @escaping (Result<AdModel, Error>)-> Void)
    func getCurrentCard(id: String, handler: @escaping (Result<CardModel, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    enum NetworkError: Error {
        case decodeError
        case dataError
        case urlError
    }
    
    private let session = URLSession.shared
    func getData(handler: @escaping (Result<AdModel, Error>)-> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")
        guard let url else {
            handler(.failure(NetworkError.urlError))
            return
        }
        start(url: url, handler: handler)
    }
    
    func getCurrentCard(id: String, handler: @escaping (Result<CardModel, Error>) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json")
        guard let url else {
            handler(.failure(NetworkError.urlError))
            return
        }
        start(url: url, handler: handler)
    }
    
    private func start<T: Decodable>(url: URL, handler: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: url) { (data, _, error) in
            if let error {
                handler(.failure(error))
                return
            }
            guard let data else {
                handler(.failure(NetworkError.dataError))
                return
            }
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                handler(.success(json))
            } catch {
                handler(.failure(NetworkError.decodeError))
            }
        }.resume()
    }
}
