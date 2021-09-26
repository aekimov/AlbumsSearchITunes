//
//  AlbumsSearchController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 24.09.2021.
//

import UIKit

//VC for albums search logic

class AlbumsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, AlbumsManagerDelegate {

    fileprivate let cellId = "cellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var albumManager = AlbumManager()
    
    var albums: [Album.Results]?
    var searchTextFromSearchField: String = ""  // text for request when using button in SearchBar - method 'searchBarSearchButtonClicked'
    var searchTextFromHistory: String {         // text for request when use history tab
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
            History.history = items
        }
            
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("SearchHistory.plist")
//        print(dataFilePath!)
    }
    
    //MARK: - Protocol Methods
    
    func didUpdateAlbums(albumResults: [Album.Results]) {
        DispatchQueue.main.async {
            self.albums = albumResults
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

        let emptyField = searchBar.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true //Check if searchText is not only spaces
        if !emptyField {
            self.albumManager.getAlbum(searchText: searchTextFromSearchField)
            History.history.append(searchTextFromSearchField)
            defaults.setValue(History.history, forKey: "SearchHistory")
            view.addSubview(activityIndicatorView)
            activityIndicatorView.centerInSuperview()
        } else { return }
    }
    
    //MARK: - CollectionView Setups
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let albumInfoVC = AlbumInfoViewController(style: .grouped)
        let collectionId = albums?[indexPath.item].collectionId // Passing collectionId for configuring request
        albumInfoVC.collectionId = collectionId
        navigationController?.pushViewController(albumInfoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3 * 16) / 2     //16 - padding on leading, trailing side and between images
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
        let album = albums?[indexPath.item]
        cell.album = album
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //logic for showing activity indicator and text label
        if albums?.count == nil {
            initialSearchTextLabel.isHidden = false
        } else if albums?.count == 0 {
            initialSearchTextLabel.isHidden = false
            activityIndicatorView.removeFromSuperview()
        } else if let number = albums?.count {
            if number > 1 {
                activityIndicatorView.removeFromSuperview()
                initialSearchTextLabel.isHidden = true
            }
        }
        return albums?.count ?? 0
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
