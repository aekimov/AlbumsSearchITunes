//
//  AlbumsSearchController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 24.09.2021.
//

import UIKit


class AlbumsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, AlbumsManagerDelegate {

    fileprivate let cellId = "cellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var albumManager = AlbumManager()
    
    var albums: Album?
    var searchTextFromSearchField: String = ""
    var searchTextFromHistory: String {
        set {
            DispatchQueue.main.async {
                self.albumManager.getAlbum(searchText: newValue)
            }
            self.view.addSubview(self.activityIndicatorView)
            self.activityIndicatorView.centerInSuperview()
        }
        get { searchController.searchBar.text ?? "" }
    }
  
    let defaults = UserDefaults.standard
   
    fileprivate let initialSearchTextLabel: UILabel = {
        let label = UILabel()
        label.text = "No results or you have not searched. \n Please enter search query."
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.color = .darkGray
    return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AlbumSearchCell.self, forCellWithReuseIdentifier: cellId)
        
        setupSearchBar()
        albumManager.delegate = self
        view.addSubview(initialSearchTextLabel)
        initialSearchTextLabel.centerInSuperview()
        self.definesPresentationContext = true
        if let items = defaults.array(forKey: "SearchHistory") as? [String] {
            searchRequests.history = items
        }
    }
    
    //MARK: - Protocol Methods
    
    func didUpdateAlbums(album: Album) {
        DispatchQueue.main.async {
            self.albums = album
            self.collectionView.reloadData()
        }
    }
    func didFailWithError(error: String) {
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "URL not found.", message: error, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.activityIndicatorView.removeFromSuperview()
            }))
            self.present(alertController, animated: true)
        }
    }
    
    //MARK: - Setup SearchBar and Methods
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextFromSearchField = searchText
        self.albums = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != " " {
        self.albumManager.getAlbum(searchText: searchTextFromSearchField)
        searchRequests.history.append(searchTextFromSearchField)
        defaults.setValue(searchRequests.history, forKey: "SearchHistory")
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        } else { return }
    }
    
    //MARK: - CollectionView Setups

    
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
        
        if albums?.resultCount == nil {
            initialSearchTextLabel.isHidden = false
            
        } else if albums?.resultCount == 0 {
            initialSearchTextLabel.isHidden = false
            activityIndicatorView.removeFromSuperview()
            
        } else if let number = albums?.resultCount {
            if number > 1 {
                activityIndicatorView.removeFromSuperview()
                initialSearchTextLabel.isHidden = true
            }
        }

        return albums?.resultCount ?? 0
    }


    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
