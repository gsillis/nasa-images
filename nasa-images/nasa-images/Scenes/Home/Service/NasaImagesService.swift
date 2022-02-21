//
//  NasaImagesService.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 05/02/22.
//

import Foundation

protocol NasaImagesServiceProtocol {
    func fetchImages(completion: @escaping (Result<AstronomyImagesModel, NetworkError>) -> Void )
}

final class NasaImagesService: NasaImagesServiceProtocol {
    
    private let serviceLayer: ServiceLayerProtocol
    
    init(serviceLayer: ServiceLayerProtocol) {
        self.serviceLayer = serviceLayer
    }
    
    func fetchImages(completion: @escaping (Result<AstronomyImagesModel, NetworkError>) -> Void) {
        guard let url = URL(string: Constants.urlPath) else { return }
        serviceLayer.fetchAstronomyImages(url: url) { response in
            switch response {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(AstronomyImagesModel.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(NetworkError.custom(error: error)))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
