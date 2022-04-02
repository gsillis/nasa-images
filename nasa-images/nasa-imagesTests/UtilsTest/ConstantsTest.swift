//
//  ConstantsTest.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 15/02/22.
//

import XCTest
@testable import nasa_images

class ConstantsTest: XCTestCase {
    func test_should_complete_with_the_same_url_path() {
        XCTAssertEqual(Constants.urlPath, "https://demo7038364.mockable.io/images")
    }
}
