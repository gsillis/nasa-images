//
//  NasaImagesViewModelProtocol.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import Foundation

protocol NasaImagesViewModelProtocol {
	func viewDidLoad()
	var nebulaImages: NebulaImagesModel? { get }
	var reloadCollectionView: (() -> Void)? { get set}
}
