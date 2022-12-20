//
//  PersonViewController.swift
//  starWarsList
//
//  Created by Aleksei Zaitsev on 19/12/2022.
//

import UIKit
import Combine

final class PersonViewController: UIViewController {
    //MARK: - Sections
    enum Section: CaseIterable {
        case persons
    }
    
    //MARK: - ContentView
    let contentView = BaseView(textFieldHeight: nil)
    
    //MARK: - ViewModel
    var viewModel: PersonViewModel?
    
    //MARK: - Binding
    private(set) var bindings = Set<AnyCancellable>()
    private var dataSource: UITableViewDiffableDataSource<Section, Person>!
    
    //MARK: - Init
    let urls: [String]?
    let statusBarFilmName: String?
    
    init(urls: [String]?, statusBarFilmName: String?) {
        self.urls = urls
        self.statusBarFilmName = statusBarFilmName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = statusBarFilmName
        view = contentView
        initialization()
    }
}

// MARK: - Initialization
extension PersonViewController {
    
    private func initialization() {
        contentView.tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        contentView.tableView.delegate = self
        setupDatasource()
        setViewModel()
    }
    
    private func setViewModel() {
        viewModel = PersonViewModel(urls: urls)

        viewModel?.fetchPersons()
        
        viewModel?.$personData
            .receive(on: RunLoop.main)
            .sink { [weak self] (data) in
                self?.createSnapshot(data)
                guard data != nil else { return }
                self?.contentView.stopActivityIndicator()
            }
            .store(in: &bindings)
    }
}

// MARK: - Diffable DataSource Setup & UITableView Delegate methods
extension PersonViewController: UITableViewDelegate {
    
    private func setupDatasource() {
        dataSource = UITableViewDiffableDataSource<Section, Person>(tableView: contentView.tableView,
                                                                    cellProvider: { [weak self] (tableView, indexPath, person) in
            let cell = self?.contentView.tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier,
                                                                       for: indexPath) as! PersonTableViewCell
            cell.person = person
            return cell
        })
    }
    
    private func createSnapshot(_ persons: [Person]?) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Person>()
        snapshot.appendSections([.persons])
        snapshot.appendItems(persons ?? [])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}

//MARK: - Transition
extension PersonViewController {
    
    private func transtion(url: String?, personName: String?) {
        let vc = WorldViewController(url: url, statusBarPersonName: personName)
        self.navigationController?.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = viewModel?.personData?[indexPath.row].homeworld
        let personName = viewModel?.personData?[indexPath.row].name
        transtion(url: url, personName: personName)
    }
}

