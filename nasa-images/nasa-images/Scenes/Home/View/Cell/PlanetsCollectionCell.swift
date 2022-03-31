//
//  PlanetsCollectionCell.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 31/03/22.
//

import UIKit
import SDWebImage

protocol PlanetsCollectionCellProtocol {
    func configure(with model: ImageModel)
}

final class PlanetsCollectionCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: PlanetsCollectionCell.self)
    }
    
    private lazy var cellIMageView: UIImageView = {
        let image = UIImageView()
        image.setupBorderImage(borderColor: .customBlue)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cellIMageView, titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 10
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
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cellIMageView.heightAnchor.constraint(equalToConstant: 70),
            cellIMageView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
}

extension PlanetsCollectionCell: PlanetsCollectionCellProtocol {
    func configure(with model: ImageModel) {
        titleLabel.text = model.name
        if let url = URL(string: model.url ?? "") {
            cellIMageView.sd_setImage(with: url, completed: nil)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct PlanetsViewPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = PlanetsCollectionCell()
            view.configure(with: ImageModel(
                url: "https://solarsystem.nasa.gov/system/resources/detail_files/439_MercurySubtleColors1200w.jpg",
                name: "Mercury",
                detail: "",
                id: ""
            ))
            return view
        }
        .previewLayout(
            .fixed(
                width: UIScreen.main.bounds.width,
                height: 90
            )
        )
    }
}

#endif

