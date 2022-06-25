//
//  FeatureCollectionCellTest.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 02/04/22.
//

import XCTest
import SnapshotTesting
@testable import nasa_images

class FeatureCollectionCellTest: XCTestCase {
    
    func test_should_complet_with_correct_feature_collection_cell_UI() {
        let sut = FeatureCollectionCell()
        let width = UIScreen.main.bounds.width
        sut.configure(with: makeViewModel())
        
        assertSnapshot(matching: sut, as: Snapshotting.image(size: CGSize(width: width, height: 350)), record: false)
    }
}
