//
//  NasaImagesViewModel.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

final class NasaImagesViewModel {
    private var service: NasaImagesServiceProtocol
    private var astronomyImages: AstronomyImages?

    init(service: NasaImagesServiceProtocol) {
        self.service = service
    }

    private func fetchNasaImages() async throws -> AstronomyImages {
        let images: AstronomyImages = try await withCheckedThrowingContinuation({ continuation in

            service.fetchAstronomyImages { result in

                switch result {
                case .success(let images):
                    continuation.resume(returning: images)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
        return images
    }

   private func images() {
        Task {
            do {
                let images = try await fetchNasaImages()
                astronomyImages = images
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
