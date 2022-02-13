//
//  NasaImagesViewModel.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

final class NasaImagesViewModel {
	private var service: NasaImagesServiceProtocol
	var reloadCollectionView: (() -> Void)?
	
	var nebulaImages: AstronomyImages? {
		didSet {
			reloadCollectionView?()
		}
	}
	
	
	init(service: NasaImagesServiceProtocol) {
		self.service = service
	}
	
	
	private func fetchNasaImages() async throws -> AstronomyImages {
		let images: AstronomyImages = try await withCheckedThrowingContinuation({ continuation in
			
			service.fetchImages { images in
				continuation.resume(returning: images)
			}
		})
		return images
	}
	
	private func images() {
		Task {
			do {
				let images = try await fetchNasaImages()
				nebulaImages = images
			} catch {
				print("Request failed with error: \(error)")
			}
		}
	}
}

extension NasaImagesViewModel: NasaImagesViewModelProtocol {
	func viewDidLoad() {
		images()
	}
}
