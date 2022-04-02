//
//  Tests+Extensions.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 16/02/22.
//

import XCTest

extension XCTestCase {
    func testMemoryLeak(instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
