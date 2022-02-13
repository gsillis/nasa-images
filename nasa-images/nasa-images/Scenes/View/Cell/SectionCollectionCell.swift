//
//  SectionCollectionCell.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 12/02/22.
//

import UIKit

protocol SectionCollectionCellProtocol {
	func configure(with title: String)
}

final class SectionCollectionCell: UICollectionViewCell {
	static var identifier: String {
		return String(describing: SectionCollectionCell.self)
	}
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .customBlue
		label.font = .systemFont(ofSize: 24, weight: .semibold)
		label.textAlignment = .left
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureSubviews()
		configureConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureSubviews() {
		self.backgroundColor = .customDarkBlue
		contentView.addSubview(titleLabel)
	}
	
	private func configureConstraints() {
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}

extension SectionCollectionCell: SectionCollectionCellProtocol {
	func configure(with title: String) {
		titleLabel.text = title
	}
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SectionCollectionCellPreview: PreviewProvider {
	static var previews: some View {
		Preview {
			let view = SectionCollectionCell()
			return view
		}
		.previewLayout(
			.fixed(
				width: UIScreen.main.bounds.width,
				height: 50
			)
		)
	}
}

#endif

