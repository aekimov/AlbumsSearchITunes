//
//  AlbumsSearchController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 24.09.2021.
//

import UIKit

class AlbumsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, AlbumsManagerDelegate {
    
    
    
//    func didUpdateSearch(text: String) {
//        DispatchQueue.main.async {
//            self.albumManager.getAlbum(searchText: text)
//            self.collectionView.reloadData()
//        }
//    }
    
    

    fileprivate let cellId = "cellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var albumManager = AlbumManager()
    var timer: Timer?
    var albums: Album?
    var searchTextField: String = ""
  
    let defaults = UserDefaults.standard
//    lazy var historyVC = HistoryViewController()
   
    fileprivate let initialSearchTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search query."
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AlbumSearchCell.self, forCellWithReuseIdentifier: cellId)
        
        setupSearchBar()
        albumManager.delegate = self
        
        view.addSubview(initialSearchTextLabel)
        initialSearchTextLabel.centerInSuperview()
        
        if let items = defaults.array(forKey: "SearchHistory") as? [String] {
            searchRequests.history = items
        }

//        historyVC.delegate = self
        
    }
    
    
    
    func didUpdateAlbums(album: Album) {
        DispatchQueue.main.async {
            self.albums = album
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
//        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.albums = nil
        searchTextField = searchText
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//            self.albumManager.getAlbum(searchText: searchText)
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.albumManager.getAlbum(searchText: searchTextField)
        
        searchRequests.history.append(searchTextField)
        defaults.setValue(searchRequests.history, forKey: "SearchHistory")
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let albumInfoVC = AlbumInfoViewController(style: .grouped)
        let collectionId = albums?.results[indexPath.item].collectionId // по этому числу будет формироваться новый запрос для списка треков
        albumInfoVC.collectionId = collectionId
        
        navigationController?.pushViewController(albumInfoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3 * 16) / 2
        return CGSize(width: width, height: width + 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AlbumSearchCell
        
        let album = albums?.results[indexPath.item]
        cell.album = album
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        initialSearchTextLabel.isHidden = albums?.results.count != nil // Если нет результатов, то убрать надпись
        return albums?.resultCount ?? 0
    }

    func didFailWithError(error: String) { //ошибка от протокола
        print(error)
    }
 
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


