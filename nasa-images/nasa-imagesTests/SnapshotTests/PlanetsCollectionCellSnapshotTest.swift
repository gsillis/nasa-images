//
//  PlanetsCollectionCellSnapshotTest.swift
//  nasa-imagesUITests
//
//  Created by Gabriela Sillis on 02/04/22.
//

import XCTest
import SnapshotTesting
@testable import nasa_images

class PlanetsCollectionCellSnapshotTest: XCTestCase {

    func test_should_complet_with_correct_planets_collection_cell_UI() {
        let sut = PlanetsCollectionCell()
        sut.configure(with: makeViewModel())
        
        assertSnapshot(matching: sut, as: Snapshotting.image(size: CGSize(width: 343, height: 44)), record: false)
    }
}



