//
//  DetailViewController.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 29/03/22.
//

import UIKit

class DetailViewController: UIViewController {
    private var viewInstance: DetailView?
    private let model: ImageModel
    
    init(model: ImageModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        viewInstance = DetailView()
        view = viewInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInstance?.configure(with: model)
    }
}
