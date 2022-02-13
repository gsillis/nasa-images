//
//  AstronomyImagesModel.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

typealias AstronomyImages = [AstronomyImagesModel]

struct AstronomyImagesModel: Decodable, Hashable {
    let url, name, detail, id: String?
    let identifier: UUID = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case url, name, detail, id
    }
}
