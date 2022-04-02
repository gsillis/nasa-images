//
//  TestFactories.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 17/02/22.
//

import Foundation
@testable import nasa_images

func makeURL() -> URL {
	return URL(string: "http://any-url.com")!
}

func makeValidData() -> Data {
    return Data()
}

func makeResponse(statusCode: Int = 200 ) -> HTTPURLResponse {
    return HTTPURLResponse(
        url: makeURL(),
        statusCode: statusCode,
        httpVersion: nil,
        headerFields: nil
    )!
}

func makeViewModel() -> ImageModel {
    return ImageModel(
        url: "Any_URL",
        name: "Mercury",
        detail: "",
        id: ""
    )
}
