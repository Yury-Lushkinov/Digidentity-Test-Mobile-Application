//
//  ItemsListViewController.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 04.06.2024.
//

import UIKit

// sourcery: AutoMockable
protocol ItemsListViewProtocol: AnyObject {
    func updateTable()
    func imageForCell(index: Int, image: UIImage)
    func showActivityIndicator()
    func hideActivityIndicator()
}

final class ItemsListViewController: UITableViewController {
    struct ReuseIdentifier {
        static let item = "ItemCell"
    }

    private let presenter: ItemsListViewPresenterProtocol

    init(presenter: ItemsListViewPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReuseIdentifier.item)

        presenter.inject(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Items list"
        presenter.loadView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}

extension ItemsListViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safe = 74.0
        let diff = tableView.contentSize.height - tableView.frame.size.height
        guard tableView.contentOffset.y >= diff + safe else {
            return
        }
        presenter.onBottomScroll()
    }
}

extension ItemsListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.item , for: indexPath)

        let item = presenter.item(indexPath.row)
        var config = cell.defaultContentConfiguration()
        config.text = item.text
        config.secondaryText = item.formatedDescription
        config.image = presenter.image(item.image)
        cell.contentConfiguration = config

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemCount
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         128
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.itemCellTouched(index: indexPath.row)
    }
}

extension ItemsListViewController: ItemsListViewProtocol {
    func updateTable() {
        tableView.reloadData()
    }

    func imageForCell(index: Int, image: UIImage) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) else {
            return
        }

        let item = presenter.item(index)
        var config = cell.defaultContentConfiguration()
        config.text = item.text
        config.secondaryText = item.formatedDescription
        config.image = image
        cell.contentConfiguration = config

    }

    func showActivityIndicator() {
        if tableView.tableFooterView == nil {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.hidesWhenStopped = true
            tableView.tableFooterView = spinner
            spinner.startAnimating()
        }
    }

    func hideActivityIndicator() {
        tableView.tableFooterView = nil
    }
}
