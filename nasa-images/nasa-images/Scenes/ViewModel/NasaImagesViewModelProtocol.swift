//
//  NasaImagesViewModelProtocol.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

protocol NasaImagesViewModelProtocol {
	func viewDidLoad()
	var astronomyImagesResult: AstronomyImagesModel? { get }
	var imagesResult: [ImageModel]? { get }
	var reloadCollectionView: (() -> Void)? { get set}
}
