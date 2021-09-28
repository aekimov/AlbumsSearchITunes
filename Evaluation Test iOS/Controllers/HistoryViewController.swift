//
//  HistoryViewController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 26.09.2021.
//

import UIKit

//VC for showing history tableView

final class HistoryViewController: UITableViewController {

    private let cellId = "cellId"
    private var cellText: String = ""
    private let albumsSearchVC = AlbumsSearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(deleteHistory))
    }
    
    @objc private func deleteHistory() {
        albumsSearchVC.defaults.removeObject(forKey: "SearchHistory")
        History.history.removeAll()
        tableView.reloadData()
    }
    


    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

// MARK: - TableView Data Source and Delegate Methods

extension HistoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndex = tableView.indexPathForSelectedRow?.row else { return }
        let cellText = History.history[selectedIndex]
        let firstTab = (tabBarController?.viewControllers?[0]) as? UINavigationController
        let vc = firstTab?.viewControllers[0] as? AlbumsSearchController
        vc?.searchTextFromHistory = cellText        //transfering text of selected row to AlbumSearchVC
        self.tabBarController?.selectedIndex = 0    //then changing tab
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = History.history[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return History.history.count
    }
}
