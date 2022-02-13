//
//  NasaImagesService.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case noData
    case invalidURL
    case custom(error: Error)
}

typealias  AstrononyImagesResult = Result<AstronomyImages, NetworkError>

protocol ServiceLayerProtocol {
    func fetchAstronomyImages(url: URL, completion: @escaping (AstrononyImagesResult) -> Void)
}

final class ServiceLayer: ServiceLayerProtocol {
    let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetchAstronomyImages(url: URL, completion: @escaping (AstrononyImagesResult) -> Void) {

        urlSession.dataTask(with: url) { astrononyImages, _, error in
            if let error = error {
                completion(.failure(NetworkError.custom(error: error)))
                return
            }

            guard let dataResult = astrononyImages else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let result = try JSONDecoder().decode(AstronomyImages.self, from: dataResult)
                completion(.success(result))
            } catch let error {
                completion(.failure(NetworkError.custom(error: error)))
            }
        }.resume()
    }
}
