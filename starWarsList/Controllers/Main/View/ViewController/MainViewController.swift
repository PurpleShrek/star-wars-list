//
//  MainViewController.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    fileprivate enum Section: CaseIterable {
        case films
    }
    
    let contentView = MainView()
    
    private(set) var bindings = Set<AnyCancellable>()
    fileprivate var dataSource: UITableViewDiffableDataSource<Section, Film>!
    
    private let viewModel = MainViewModel()
    
    private(set) var ticketForIndexPath: [IndexPath: AnyCancellable] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        textFieldsPreferences()
        connectTextField()
        initialization()
    }
}

// MARK: - Initialization
extension MainViewController {
    
    private func initialization() {
        contentView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        contentView.tableView.delegate = self
        setupDatasource()
        viewModel.loadNews()
        
        viewModel.$films
            .receive(on: RunLoop.main)
            .sink { [weak self] (data) in
                self?.createSnapshot(data?.results)
                guard data != nil else { return }
                self?.contentView.stopActivityIndicator()
            }
            .store(in: &bindings)
    }
}

// MARK: - Diffable DataSource Setup & UITableView Delegate methods
extension MainViewController: UITableViewDelegate {
    
    fileprivate func setupDatasource() {
        dataSource = UITableViewDiffableDataSource<Section, Film>(tableView: contentView.tableView,
                                                                  cellProvider: { [weak self] (tableView, indexPath, film) in
            let cell = self?.contentView.tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,
                                                                       for: indexPath) as! MainTableViewCell
            cell.index = indexPath
            cell.viewModel = MainCellViewModel(film: film)
            
            self?.ticketForIndexPath[indexPath] = cell.tapCell
                .sink(receiveValue: { index in
                    print(index)
                })
            
            return cell
        })
    }
    
    fileprivate func createSnapshot(_ films: [Film]?) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Film>()
        snapshot.appendSections([.films])
        snapshot.appendItems(films ?? [])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        142
    }
}
