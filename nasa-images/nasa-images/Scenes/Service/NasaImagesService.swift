//
//  NasaImagesService.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 05/02/22.
//

import Foundation

protocol NasaImagesServiceProtocol {
	func fetchImages(completion: @escaping (AstronomyImages) -> Void )
}

class NasaImagesService: NasaImagesServiceProtocol {
	
	private let serviceLayer: ServiceLayerProtocol
	
	init(serviceLayer: ServiceLayerProtocol) {
		self.serviceLayer = serviceLayer
	}
	
	func fetchImages(completion: @escaping (AstronomyImages) -> Void) {
		guard let url = URL(string: Constants.urlPath) else { return }
		serviceLayer.fetchAstronomyImages(url: url) { response in
			switch response {
			case .success(let result):
				completion(result)
			case .failure(let error):
				print(error)
			}
		}
	}
}
