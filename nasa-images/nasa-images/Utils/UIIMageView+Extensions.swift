//
//  UIIMageView+Extensions.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/03/22.
//

import UIKit

extension UIImageView {
    func setupBorderImage(borderColor: UIColor) {
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 2.5
    }
}
