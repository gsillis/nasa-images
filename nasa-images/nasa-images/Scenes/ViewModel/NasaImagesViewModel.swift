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
	
	var nebulaImages: NebulaImagesModel? {
		didSet {
			reloadCollectionView?()
		}
	}
	
	
	init(service: NasaImagesServiceProtocol) {
		self.service = service
	}
	
	
	private func fetchNasaImages() async throws -> NebulaImagesModel {
		let images: NebulaImagesModel = try await withCheckedThrowingContinuation({ continuation in
			service.fetchImages { images in
				switch images {
				case .success(let result):
					continuation.resume(returning: result)
				case .failure(let error):
					print(error)
				}
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
