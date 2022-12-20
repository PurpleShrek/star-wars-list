//
//  MainViewController.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 14/12/2022.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
    //MARK: - Sections
    enum Section: CaseIterable {
        case films
    }
    
    //MARK: - ContentView
    let contentView = BaseView(textFieldHeight: 40)
    
    //MARK: - ViewModel
    let viewModel = MainViewModel()
    
    //MARK: - Binding
    var bindings = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Section, Film>!
    
    //MARK: - Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        initialization()
        textFieldPrferences()
        textFieldEvents()
    }
}

// MARK: - Initialization
extension MainViewController {

    private func initialization() {
        contentView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        contentView.tableView.delegate = self
        setupDatasource()
        setViewModel()
    }
    
    private func setViewModel() {
        viewModel.fetchFilms()
        
        viewModel.$films
            .receive(on: RunLoop.main)
            .sink { [weak self] (data) in
                self?.createSnapshot(data?.results)
                guard data != nil else { return }
                self?.contentView.stopActivityIndicator()
            }
            .store(in: &bindings)
        
        viewModel.$loadState
            .receive(on: RunLoop.main)
            .sink { [weak self] (state) in
                guard !state else { return }
                self?.contentView.showRepeatButton()
                self?.requestButtonBinding()
            }
            .store(in: &bindings)
    }
    
    private func requestButtonBinding() {
        contentView.requestButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.contentView.hideButtonShowActivity()
                self?.viewModel.fetchFilms()
            }
            .store(in: &bindings)
    }
}


// MARK: - Diffable DataSource Setup & UITableView Delegate methods
extension MainViewController: UITableViewDelegate {
    
    private func setupDatasource() {
        dataSource = UITableViewDiffableDataSource<Section, Film>(tableView: contentView.tableView,
                                                                  cellProvider: { [weak self] (tableView, indexPath, film) in
            let cell = self?.contentView.tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier,
                                                                       for: indexPath) as! MainTableViewCell
            cell.film = film
            return cell
        })
    }
    
    private func createSnapshot(_ films: [Film]?) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Film>()
        snapshot.appendSections([.films])
        snapshot.appendItems(films ?? [])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        142
    }
}

//MARK: - Transition
extension MainViewController {
    
    private func transtion(urls: [String]?, filmName: String?) {
        let vc = PersonViewController(urls: urls, statusBarFilmName: filmName)
        self.navigationController?.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urls = viewModel.films?.results?[indexPath.row].characters
        let filmName = viewModel.films?.results?[indexPath.row].title
        transtion(urls: urls, filmName: filmName)
    }
}
