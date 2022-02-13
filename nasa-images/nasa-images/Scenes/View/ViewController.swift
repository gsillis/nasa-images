//
//  ViewController.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import UIKit

class ViewController: UIViewController {
    private enum Section {
      case main
    }
    
    private typealias UserDataSource = UICollectionViewDiffableDataSource<Section, AstronomyImages>
    private typealias SnapshotData = NSDiffableDataSourceSnapshot<Section, AstronomyImages>
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
    private lazy var dataSource: UserDataSource = createDataSource()
    
    private let viewModel: NasaImagesViewModelProtocol

    init(viewModel: NasaImagesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customDarkBlue
        viewModel.viewDidLoad()
    }
    
//    private func createHeader() {
//        dataSource.supplementaryViewProvider = { collectionview, kind, indexpath in
//        }
//    }

    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewLayout()
    }
    
    private func createCustomCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NebulaCollectionCell.identifier,
            for: indexPath) as? NebulaCollectionCell else {
                return UICollectionViewCell()
            }
        return cell
    }
    
    private func createDataSource() -> UserDataSource {
        UserDataSource(collectionView: collectionView) { collection, indexPath, app in
            return self.createCustomCell(indexPath: indexPath)
        }
    }
    
    private func createNebulaCollectSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
//        let header = createHeader()
//        layoutSection.boundarySupplementaryItems = [header]
        return layoutSection
    }
}
