//
//  HistoryViewController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 26.09.2021.
//

import UIKit

//protocol UpdateSearchDelegate {
//    func didUpdateSearch(text: String)
//}

class HistoryViewController: UITableViewController {
    
    
    
    
    fileprivate let cellId = "cellId"
    let albumsSearchVC = AlbumsSearchController()

    var history: [String] = []
    fileprivate var cellText: String = ""

//    var delegate: UpdateSearchDelegate?
    
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
//        present(albumsSearchVC, animated: true, completion: nil)
//        albumsSearchVC.searchTextField = cellText
        
//        var firstTab = (tabBarController?.viewControllers![0])! as! UINavigationController
//        firstTab = cellText
        
        
//        delegate?.didUpdateSearch(text: cellText)
//        self.tabBarController?.selectedIndex = 0
        print(cellText)
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
