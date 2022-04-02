//
//  NebulaCollectionCellTest.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 02/04/22.
//

import XCTest
import SnapshotTesting
@testable import nasa_images

class NebulaCollectionCellTest: XCTestCase {
    
    func test_should_complet_with_correct_nabula_collection_cell_UI() {
        let sut = NebulaCollectionCell()
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        sut.configure(with: makeViewModel())
        
        assertSnapshot(matching: sut, as: Snapshotting.image(size: CGSize(width: width, height: height)), record: false)
    }
}

