//
//  AstronomyImagesModel.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

typealias AstronomyImages = [AstronomyImagesModel]

struct AstronomyImagesModel: Decodable, Equatable {
    let url, name, detail, id: String?
}
