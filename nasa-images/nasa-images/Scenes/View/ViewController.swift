//
//  ViewController.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/01/22.
//

import UIKit

class ViewController: UIViewController {
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
}
