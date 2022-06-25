//
//  SectionCollectionCellSnapshotTest.swift
//  nasa-imagesTests
//
//  Created by Gabriela Sillis on 02/04/22.
//


import XCTest
import SnapshotTesting
@testable import nasa_images

class SectionCollectionCellTest: XCTestCase {
    
    func test_should_complet_with_correct_section_collection_cell_UI() {
        let sut = SectionCollectionCell()
        let width = UIScreen.main.bounds.width
        sut.configure(with: "Teste")
        
        assertSnapshot(matching: sut, as: Snapshotting.image(size: CGSize(width: width, height: 50)), record: false)
    }
}
