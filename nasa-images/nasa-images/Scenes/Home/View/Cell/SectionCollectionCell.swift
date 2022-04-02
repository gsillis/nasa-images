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
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .quaternaryLabel
        return view
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
        contentView.addSubview(separatorView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: contentView.topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
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
            view.configure(with: "Section")
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

