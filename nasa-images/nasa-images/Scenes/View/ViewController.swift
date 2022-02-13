//
//  ViewController.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import UIKit

class ViewController: UIViewController {
	
	private typealias UserDataSource = UICollectionViewDiffableDataSource<SectionsModel, ImageModel>
	private typealias SnapshotData = NSDiffableDataSourceSnapshot<SectionsModel, ImageModel>
		
	private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
	private lazy var dataSource: UserDataSource = createDataSource()
	private var sections: [SectionsModel]?
	private var viewModel: NasaImagesViewModelProtocol
	
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
		configureSubviews()
		configureConstraints()
		registerCollectionViewCell()
		createHeader()
		bindUI()
	}
	
	private func bindUI() {
		viewModel.reloadCollectionView = { [weak self] in
			DispatchQueue.main.async {
				self?.reloadSnapshotData()
			}
		}
	}
	
	private func registerCollectionViewCell() {
		collectionView.register(
			SectionCollectionCell.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: SectionCollectionCell.identifier
		)
		collectionView.register(NebulaCollectionCell.self, forCellWithReuseIdentifier: NebulaCollectionCell.identifier)
	}
	
	private func reloadSnapshotData() {
		var snapShot = SnapshotData()
		guard let section = viewModel.nebulaImages?.result else { return }
		snapShot.appendSections(section)
		section.forEach { section in
			guard let item = section.nebula else { return }
			snapShot.appendItems(item, toSection: section)
		}
		dataSource.apply(snapShot)
	}
	
	private func createHeader() {
		dataSource.supplementaryViewProvider = { [weak self] collectionview, kind, indexpath in
			let sections = self?.viewModel.nebulaImages?.result?[indexpath.section].section
			switch sections {
			case "Nebula":
				guard let sectionHeader = collectionview.dequeueReusableSupplementaryView(
					ofKind: kind,
					withReuseIdentifier: SectionCollectionCell.identifier,
					for: indexpath) as? SectionCollectionCell else {
						return nil
					}
				guard let app = self?.dataSource.itemIdentifier(for: indexpath) else { return nil }
				let section = self?.dataSource.snapshot().sectionIdentifier(containingItem: app)
				
				guard !(section?.section?.isEmpty ?? false) else { return nil }
				sectionHeader.configure(with: section?.section ?? "")
				return sectionHeader
			default:
				return nil
			}
		}
	}
	
	private func createCompositionalLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
			let section = self?.viewModel.nebulaImages?.result?[sectionIndex]
			switch section?.section {
			default:
				return self?.createNebulaCollectSection()
			}
		}
		let configure = UICollectionViewCompositionalLayoutConfiguration()
		configure.interSectionSpacing = 20
		layout.configuration = configure
		return layout
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
		UserDataSource(collectionView: collectionView) { [weak self] _, indexPath, _ in
			switch self?.viewModel.nebulaImages?.result?[indexPath.section].section {
			default:
				return self?.createCustomCell(indexPath: indexPath)
			}
		}
	}
	
	private func createNebulaCollectSection() -> NSCollectionLayoutSection {
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(0.2)
		)
		let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
		let layoutGroupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.9),
			heightDimension: .estimated(200)
		)
		let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
		let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
		let header = createSectionHeader()
		layoutSection.boundarySupplementaryItems = [header]
		return layoutSection
	}
	
	private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let headerSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(0.9),
			heightDimension: .estimated(40)
		)
		let layoutHeader = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerSize,
			elementKind: UICollectionView.elementKindSectionHeader,
			alignment: .top
		)
		return layoutHeader
	}
	
	private func configureSubviews() {
		view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false 
	}
	
	private func configureConstraints() {
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
		])
	}
}
