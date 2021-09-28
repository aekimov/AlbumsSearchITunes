//
//  SongsViewController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 25.09.2021.
//

import UIKit

//VC for showing info and songs

final class AlbumInfoViewController: UITableViewController {

    private let cellId = "cellId"
    private let albumManager = AlbumManager()
    private let albumViewForHeader = AlbumInfoViewForHeader() //View for tableView header
    private let headerView = AlbumInfoViewForHeader()
    
    var collectionId: Int?
    private var albumInfo: AlbumInfoModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(AlbumInfoCell.self, forCellReuseIdentifier: cellId) //register cell
        guard let collectionId = collectionId else { return }
        fetchData(collectionId) // request to show info and songs using collectionId
    }
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.color = .darkGray
    return indicator
    }()
    
    //MARK: - Process Result With Model and Error
    
    private func fetchData(_ collectionId: Int) {
        
        albumManager.getAlbumInfoAndSongs(collectionId) { result in
            switch result {
            case .success(let albumInfo):
                DispatchQueue.main.async {
                    self.albumInfo = albumInfo //if success then fill tableview cells with data from albumInfo
                    self.tableView.reloadData()
                }
                
            case .failure(let apiError): // if falure then gererate error and show alert
                switch apiError {
                case .error(let errorString):
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Something went wrong.", message: errorString, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                            self.activityIndicatorView.removeFromSuperview()
                        }))
                        self.present(alertController, animated: true)
                    }
                }
            }
        }
    }
}

//MARK: - TableView DataSource and Delegate Methods

extension AlbumInfoViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let albumInfo = albumInfo else { return 0 }
        return albumInfo.results.count - 1 == 0 ? 1 : albumInfo.results.count - 1 //if only 1 result then use 1 row, if more than 1 result then decrement by 1 because zero element is album description
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? AlbumInfoCell) else { return UITableViewCell() }
        cell.backgroundColor = .white
        if albumInfo?.results.count == 1 {
            cell.albumInfo = albumInfo?.results[indexPath.row] // if there if only 1 element
        } else {
            //if there are >1 element then start from first element because zero element is album description
            cell.albumInfo = albumInfo?.results[indexPath.row + 1]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if albumInfo?.resultCount != nil {
            headerView.headerInfo = albumInfo
            return headerView
        } else {
            self.view.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.centerInSuperview()
            return activityIndicatorView
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return albumInfo?.resultCount == 0 ? view.frame.height : 150
    }
}

