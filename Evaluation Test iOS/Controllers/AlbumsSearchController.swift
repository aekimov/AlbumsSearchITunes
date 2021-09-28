//
//  AlbumsSearchController.swift
//  Evaluation Test iOS
//
//  Created by Artem Ekimov on 24.09.2021.
//

import UIKit

//VC for albums search logic

final class AlbumsSearchController: UICollectionViewController, UISearchBarDelegate {

    private let cellId = "cellId"
    private let searchController = UISearchController(searchResultsController: nil)
    private let albumManager = AlbumManager()
    let defaults = UserDefaults.standard   // UD to save our history

    private var albums: [Results]?
    var searchTextFromHistory: String {         // text for request when use history tab
        set {
            fetchData(searchText: newValue)     //if we text from history table then we need to use this text to make request
            navigationController?.popToRootViewController(animated: true) // pop to rootVC to show results
            self.view.addSubview(self.activityIndicatorView) //show loading indicator
            self.activityIndicatorView.centerInSuperview()
            self.searchController.searchBar.text = newValue
        }
        get { searchController.searchBar.text ?? "" }
    }
   
    private let initialSearchTextLabel: UILabel = { //label that show if we have results or not
        let label = UILabel()
        label.text = "No results or you have not searched. \n Please enter search query."
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        indicator.color = .darkGray
    return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupUI()
        
        if let items = defaults.array(forKey: "SearchHistory") as? [String] { //fetch history from UD when app starts
            History.history = items
        }
    }
    
    private func setupUI() { // collectionView and label setups
        collectionView.backgroundColor = .white
        collectionView.register(AlbumSearchCell.self, forCellWithReuseIdentifier: cellId)
        self.definesPresentationContext = true
        
        view.addSubview(initialSearchTextLabel)
        initialSearchTextLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 150, left: 16, bottom: 0, right: 16))
    }
    
    //MARK: - Setup SearchBar and Methods
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else { return }
        
        if !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty { //Check if searchText is not only spaces
            fetchData(searchText: searchQuery) //fetch data with search text from search bar
            History.history.append(searchQuery) // add to history array
            defaults.setValue(History.history, forKey: "SearchHistory") // add to UD
            view.addSubview(activityIndicatorView)
            activityIndicatorView.centerInSuperview()
        } else { return }
    }
    
    
    //MARK: - Process Result With Model and Error
    
    private func fetchData(searchText: String) {
        var sortedResults = [Results]()
        
        albumManager.getAlbum(searchText) { result in
            switch result {
            case .success(let album): //if success then fill collectionView items with data from album
                sortedResults = album.results.sorted { $0.collectionName < $1.collectionName } //Sort in alphabetical order
                
                DispatchQueue.main.async {
                    self.albums = sortedResults
                    self.collectionView.reloadData()
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
    
    //MARK: - Inits
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - CollectionView Delegate Methods

extension AlbumsSearchController: UICollectionViewDelegateFlowLayout {
    
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
        guard let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? AlbumSearchCell) else { return UICollectionViewCell() }
        let album = albums?[indexPath.item]
        cell.album = album
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //logic for showing activity indicator and label
        if albums?.count == nil {
            initialSearchTextLabel.isHidden = false
        } else if albums?.count == 0 {
            initialSearchTextLabel.isHidden = false
            activityIndicatorView.removeFromSuperview()
        } else if let number = albums?.count {
            if number > 0 {
                activityIndicatorView.removeFromSuperview()
                initialSearchTextLabel.isHidden = true
            }
        }
        return albums?.count ?? 0
    }
}
