//
//  NebulaCollectionCell.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 12/02/22.

import UIKit

final class NebulaCollectionCell: UICollectionViewCell {
	static var identifier: String {
		return String(describing: NebulaCollectionCell.self)
	}
	
	private lazy var cellIMageView: UIImageView = {
		let image = UIImageView()
		image.layer.cornerRadius = 8
		image.layer.borderWidth = 3
		image.layer.borderColor = UIColor.customBlue.cgColor
		image.clipsToBounds = true
		image.image = UIImage(named: "nebula")
		image.contentMode = .scaleAspectFill
		return image
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .regular)
		label.text = "TESTE"
		label.textColor = .white
		return label
	}()
	
	private lazy var stackView: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [cellIMageView, titleLabel])
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.spacing = 16
		return stack
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
		contentView.addSubview(stackView)
	}
	
	private func configureConstraints() {
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			stackView.heightAnchor.constraint(equalToConstant: 300)
		])
	}
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ListTableViewPreview: PreviewProvider {
	static var previews: some View {
		Preview {
			let view = NebulaCollectionCell()
			return view
		}
		.previewLayout(
			.fixed(
				width: UIScreen.main.bounds.width,
				height: 350
			)
		)
	}
}

#endif
