//
//  ServiceLayerTest.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 29/01/22.
//

import XCTest
@testable import nasa_images

class ServiceLayerTest: XCTestCase {
	
	func test_should_complete_with_correct_url_and_method() {
		let url = makeURL()
		testRequestFor(url: makeURL()) { request  in
			XCTAssertEqual(url, request.url)
			XCTAssertEqual("GET", request.httpMethod)
		}
	}
}

extension ServiceLayerTest {
	func makeSut(file: StaticString = #filePath, line: UInt = #line) -> ServiceLayer {
		let configuration = URLSessionConfiguration.default
		configuration.protocolClasses = [URLProtocolStub.self]
		let session = URLSession(configuration: configuration)
		let sut = ServiceLayer(urlSession: session)
		testMemoryLeak(instance: sut, file: file, line: line)
		return sut
	}
	
	func testRequestFor(url: URL, completion: @escaping (URLRequest) -> Void ) {
		let sut = makeSut()
		sut.fetchAstronomyImages(url: url) { _ in }
		let exp = expectation(description: "waiting")
		URLProtocolStub.observerRequest { request in
			completion(request)
			exp.fulfill()
		}
		wait(for: [exp], timeout: 1)
	}
}
