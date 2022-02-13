//
//  ServiceLayerTest.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 29/01/22.
//

import XCTest
@testable import nasa_images

class ServiceLayerTest: XCTestCase {

    func test_should_complete_with_correct_url() {
        // given
        let url = makeURL()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = ServiceLayer(urlSession: session)
        // when
        sut.fetchAstronomyImages(url: url) { _ in }

        let exp = expectation(description: "waiting")
        URLProtocolStub.observerRequest { request in
            // then
            XCTAssertEqual(url, request.url)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

/// Helper
func makeURL() -> URL {
    return URL(string: "http://any-url.com")!
}

/// Stub

class URLProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?

    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        URLProtocolStub.emit = completion
    }

    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return  request
    }

    override open func startLoading() {
        URLProtocolStub.emit?(request)
    }

    override open func stopLoading() {}
}
