//
//  AstronomyImagesModel.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

protocol Model: Decodable, Hashable {}

struct AstronomyImagesModel: Model {
	let result: [SectionsModel]?
	let identifier: UUID = UUID()
	
	private enum CodingKeys: String, CodingKey {
		case result
	}
}

struct SectionsModel: Model {
	let section: String?
	let object: [ImageModel]?
}

struct ImageModel: Model {
	let url, name, detail, id: String?
}
