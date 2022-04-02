//
//  UIColor+Extensions.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 12/02/22.
//

import UIKit

extension UIColor {
	convenience init(customRed: Int, customGreen: Int, customBlue: Int) {
		self.init(
			red: CGFloat(customRed) / 255.0,
			green: CGFloat(customGreen) / 255.0,
			blue: CGFloat(customBlue) / 255.0,
			alpha: 1
		)
	}
	
    static let customBlue = UIColor(customRed: 120, customGreen: 175, customBlue: 255)
    static let customDarkBlue = UIColor(customRed: 38, customGreen: 28, customBlue: 44)
    static let customPurpleDark = UIColor(customRed: 18, customGreen: 14, customBlue: 21)
}
