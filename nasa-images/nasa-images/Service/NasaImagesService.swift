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

typealias  AstrononyImages = Result<[AstronomyImages], NetworkError>

protocol NasaImagesServiceProtocol {
    func fetchAstronomyImages(completion: @escaping (AstrononyImages) -> Void)
}

final class NasaImagesService: NasaImagesServiceProtocol {
    func fetchAstronomyImages(completion: @escaping (AstrononyImages) -> Void) {
        guard let url = URL(string: Constants.urlPath) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let urlSession = URLSession.shared
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
                let result = try JSONDecoder().decode([AstronomyImages].self, from: dataResult)
                completion(.success(result))
            } catch let error {
                completion(.failure(NetworkError.custom(error: error)))
            }
        }.resume()
    }
}
