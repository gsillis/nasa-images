//
//  UIColorTest.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 13/02/22.
//

import XCTest
@testable import nasa_images

class UIColorTest: XCTestCase {
	func test_should_calculate_correct_red_blue_green_value() {
		// given
		let sut = UIColor(customRed: 255, customGreen: 51, customBlue: 51)
		let expRed = CGFloat(255)/255
		let expBlue = CGFloat(51)/255
		let expGreen = CGFloat(51)/255
		
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		// when
		sut.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		
		// then
		XCTAssertEqual(red, expRed)
		XCTAssertEqual(green, expGreen)
		XCTAssertEqual(blue, expBlue)
	}
	
}

