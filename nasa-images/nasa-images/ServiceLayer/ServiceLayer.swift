//
//  NasaImagesService.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

protocol ServiceLayerProtocol {
    func fetchAstronomyImages(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class ServiceLayer: ServiceLayerProtocol {
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchAstronomyImages(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        var urlResquest = URLRequest(url: url)
        urlResquest.httpMethod = "GET"
        urlSession.dataTask(with: urlResquest) { astrononyImages, response, error in
            if let error = error {
                completion(.failure(NetworkError.custom(error: error)))
                return
            }
            
            guard let dataResult = astrononyImages else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            switch httpResponse?.statusCode {
            case 200:
                completion(.success(dataResult))
            default:
                completion(.failure(NetworkError.badRequest))
            }
        }.resume()
    }
}
