//
//  DetailView.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/03/22.
//

import UIKit
import SDWebImage

protocol DetailViewProtocol {
    func configure(with data: ImageModel?)
}

final class DetailView: UIView {
    
    private lazy var astronomyImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.setupBorderImage(borderColor: .customBlue)
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [astronomyImage, titleLabel, detailLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
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
        backgroundColor = .customDarkBlue
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            astronomyImage.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}

extension DetailView: DetailViewProtocol {
    func configure(with model: ImageModel?) {
        guard let model = model else { return }
        if let url = URL(string: model.url ?? "") {
            astronomyImage.sd_setImage(with: url, completed: nil)
        }
        titleLabel.text = model.name
        detailLabel.text = model.detail
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DetailPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = DetailView()
            return view
        }
        .previewLayout(
            .fixed(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
    }
}

#endif

