//
//  HistoryViewController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 26.09.2021.
//

import UIKit


class HistoryViewController: UITableViewController {
    

    fileprivate let cellId = "cellId"
    fileprivate var cellText: String = ""
    let albumsSearchVC = AlbumsSearchController()
    var history: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("SearchHistory.plist")
//        print(dataFilePath!)
        
        }

    override func viewWillAppear(_ animated: Bool) {
        history = searchRequests.history
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndex = tableView.indexPathForSelectedRow?.row else { return }
        let cellText = history[selectedIndex]
//        albumsSearchVC.searchTextField = cellText
        
        let firstTab = (tabBarController?.viewControllers![0])! as! UINavigationController
        let vc = firstTab.viewControllers[0] as! AlbumsSearchController
        vc.searchTextFromHistory = cellText
        self.tabBarController?.selectedIndex = 0

    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = history[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }





}
