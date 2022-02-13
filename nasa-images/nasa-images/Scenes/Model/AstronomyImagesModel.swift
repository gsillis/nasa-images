//
//  AstronomyImagesModel.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

protocol Model: Decodable, Hashable {}
typealias NebulaImagesModel = NebulaImagesSections

struct NebulaImagesSections: Model {
	let section: String?
	let identifier: UUID = UUID()
	let nebula: [NebulaImages]?
	
	private enum CodingKeys: String, CodingKey {
		case section, nebula
	}
}

struct NebulaImages: Model {
	let url, name, detail, id: String?
}
