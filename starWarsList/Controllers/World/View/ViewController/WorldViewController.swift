//
//  WorldViewController.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import UIKit
import Combine

final class WorldViewController: UIViewController {
    //MARK: - ContentView
    let contentView = WorldView()

    //MARK: - Binding
    private(set) var bindings = Set<AnyCancellable>()
    
    //MARK: - Init
    let url: String?
    let statusBarPersonName: String?
    
    init(url: String?, statusBarPersonName: String?) {
        self.url = url
        self.statusBarPersonName = statusBarPersonName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = statusBarPersonName //set nav bar title
        view = contentView //connect contentview
        let viewModel = WorldViewModel(url: url) //set viewModel
        
        viewModel.$world //bind loading data about persons world
            .receive(on: RunLoop.main)
            .sink { [weak self] (data) in
                self?.contentView.setLabels(world: data)
                guard data != nil else { return }
                self?.contentView.stopActivityIndicator()
            }
            .store(in: &bindings)
    }
}
