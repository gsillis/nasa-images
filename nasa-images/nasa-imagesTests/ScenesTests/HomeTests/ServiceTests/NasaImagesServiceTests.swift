//
//  NasaImagesServiceTests.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 25/06/22.
//

import XCTest
@testable import nasa_images

final class NasaImagesServiceTests: XCTestCase {

}

class ServiceLayerSpy: ServiceLayerProtocol {
    private(set) var urlRequestPassed: String?
    private(set) var requestCount: Int = 0
    private(set) var wasRequestCalled: Bool = false
    var dataToBeReturned: Data = Data()
    var errorToBeReturned: NetworkError = .badRequest
    
    func fetchAstronomyImages(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        urlRequestPassed = url.absoluteString
        requestCount += 1
        wasRequestCalled = true
        completion(.success(dataToBeReturned))
        completion(.failure(errorToBeReturned))
    }
}
