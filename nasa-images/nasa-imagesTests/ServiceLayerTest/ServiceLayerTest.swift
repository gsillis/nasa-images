//
//  ServiceLayerTest.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 29/01/22.
// swiftlint:disable line_length

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

    func test_should_complete_with_success_when_request_completes_with_200() {
        expectResult(.success(makeValidData()), when: (makeValidData(), makeResponse(), nil))
    }

    func test_should_complete_with_failure_when_request_completes_with_non_200() {
        expectResult(.failure(.badRequest), when: (makeValidData(), makeResponse(statusCode: 400), nil))
    }
}

extension ServiceLayerTest {
    typealias StubTuple = (data: Data?, response: HTTPURLResponse?, error: Error?)
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> ServiceLayer {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = ServiceLayer(urlSession: session)
        testMemoryLeak(instance: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL, completion: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.fetchAstronomyImages(url: url) { _ in exp.fulfill() }
        var request: URLRequest?
        URLProtocolStub.observerRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        completion(request!)
    }
    
    func expectResult(_ expectedResult: (Result<Data, NetworkError>), when stub: StubTuple, file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        URLProtocolStub.simulatedata(data: stub.data, response: stub.response, error: stub.error)
        
        let exp = expectation(description: "waiting")
        sut.fetchAstronomyImages(url: makeURL()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.success(let expSuccess), .success(let receveidSuccess)):
                XCTAssertEqual(expSuccess, receveidSuccess, file: file, line: line)
            case (.failure(let expError), .failure(let receveidError)):
                XCTAssertEqual(expError, receveidError, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
