//
//  NasaImagesServiceTests.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 25/06/22.
//  swiftlint:disable line_length

import XCTest
@testable import nasa_images

final class NasaImagesServiceTests: XCTestCase {
    private let serviceLayerSpy = ServiceLayerSpy()
    private lazy var sut = NasaImagesService(serviceLayer: serviceLayerSpy)
    var result: (Result<AstronomyImagesModel, NetworkError>) = .failure(.noData)
    
    
    func testFetchImages_ShouldCallFetchAstronomyImagesOnce_WithCorrectUrl() {
        sut.fetchImages { _ in }
        XCTAssertEqual(serviceLayerSpy.urlRequestPassed, url)
        XCTAssertEqual(serviceLayerSpy.requestCount, 1)
        XCTAssertTrue(serviceLayerSpy.wasRequestCalled)
    }
    
    func testFetchImages_ShouldCompletesWithValidData() {
        let exp = expectation(description: "waiting")
        sut.fetchImages { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.result?.first?.section, "James Webb")
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
            exp.fulfill()
        }
        serviceLayerSpy.completeWith(data: defaultValidData)
        wait(for: [exp], timeout: 1)
    }
    
    func testFetchImages_ShouldCompletesWithError_IfInvalidDataIsProvided() {
        let exp = expectation(description: "waiting")
        
        sut.fetchImages { result in
            switch result {
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            exp.fulfill()
        }
        serviceLayerSpy.completeWith(data: defaultInvalidData)
        wait(for: [exp], timeout: 1)
    }
}

private extension NasaImagesServiceTests {
    var url: String {
        return "https://demo7038364.mockable.io/images"
    }
    
    var defaultValidData: Data {
        return """
        {
          "result": [
              {
                  
              "section": "James Webb",
              "object": [
                {
                  "url": "https://www.nasa.gov/sites/default/files/thumbnails/image/telescope_alignment_evaluation_image_labeled.png",
                  "name": "NASA’s Webb Reaches Alignment Milestone, Optics Working Successfully",
                  "detail": "Following the completion of critical mirror alignment steps, NASA’s James Webb Space Telescope team expects that Webb’s optical performance will be able to meet or exceed the science goals the observatory was built to achieve.",
                  "id": "1"
                }
              ]
            }
          ]
        }
        """.data(using: .utf8) ?? Data()
    }
    
    var defaultInvalidData: Data {
        return """
        [
          {
            
          }
        ]
        """.data(using: .utf8) ?? Data()
    }
    
}

class ServiceLayerSpy: ServiceLayerProtocol {
    private(set) var urlRequestPassed: String?
    private(set) var requestCount: Int = 0
    private(set) var wasRequestCalled: Bool = false
    var observer: ((Result<Data, NetworkError>) -> Void)?
    
    func fetchAstronomyImages(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        urlRequestPassed = url.absoluteString
        requestCount += 1
        wasRequestCalled = true
        observer = completion
    }
    
    func completeWith(error: NetworkError) {
        observer?(.failure(error))
    }
    
    func completeWith(data: Data) {
        observer?(.success(data))
    }
}
