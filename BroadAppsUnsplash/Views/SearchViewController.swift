//
//  SearchViewController.swift
//  BroadAppsUnsplash
//
//  Created by Mishana on 10.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var fetchData = DataFetcher()
    private var images = [Images]()
    private var timer: Timer?
    var collection:  UICollectionView!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInerts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUINavigation()
        setupSearchBar()
        addCollection()
    }
    
    private func setupUINavigation() {
        title = "Search"
        view.backgroundColor = .tintColor
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.hidesNavigationBarDuringPresentation = false
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        search.searchBar.delegate = self
    }
    
    private func addCollection() {
        collection = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.register(SearchViewCell.self, forCellWithReuseIdentifier: SearchViewCell.identifier)
        collection.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        collection.contentInsetAdjustmentBehavior = .automatic
        collection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collection)
        collection.dataSource = self
        collection.delegate = self
    }
    
    
}

// MARK:  UICollectionViewDelegate, UICollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: SearchViewCell.identifier, for: indexPath) as! SearchViewCell
        
        let image = images[indexPath.item]
        cell.loadImage = image
        return cell
    }
}

// MARK:  UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = images[indexPath.item]
        let padding = sectionInerts.left * (itemsPerRow + 1)
        let widthAvale = view.frame.width - padding
        let widthPerItem = widthAvale / itemsPerRow
        let heightPerItem = CGFloat(image.height) * widthPerItem / CGFloat(image.width)
        return CGSize(width: widthPerItem, height: heightPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInerts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInerts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = images[indexPath.item].id
        let image = images[indexPath.item]
        let vc = DescriptionItem()
        vc.add(like: false)
        
        self.fetchData.fetchDataDescription(id: id) {[weak self] (descrip) in
            guard let fetchDescription = descrip else {
                return Alert.showAlertNoInternet(on: vc, with: "Сheck internet connection", message: "The answer didn't come")
            }
            let date = DateFormatter()
            date.locale = Locale(identifier: "en_US_POSIX")
            date.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateFor = date.date(from: fetchDescription.createdAt)!
            
            vc.loadData = descrip
            vc.title = descrip!.user.name
            vc.downloadLabel.text = "Downloads: \(fetchDescription.downloads)"
            vc.likesLabel.text = "Create: \(dateFor)"
            
            if let location = fetchDescription.location.country{
                vc.locationLabel.text = "Location: \(location)"
            }
        }
        
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true


        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large() ]
        }
        present(nav, animated: true, completion: nil)
        collection.deselectItem(at: indexPath, animated: true)
    }
}



// MARK:  UISearchBarDelegate


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.fetchData.fetchImage(searchTerm: searchText) {[weak self] (searchResult) in
                guard let fetchImages = searchResult else {return Alert.showAletrSearchControllerNoInternet(on: SearchViewController(), with: "Сheck internet connection", message: "The answer didn't come")
                }
                self?.images = fetchImages.results
                self?.collection.reloadData()
            }
        })
    }
    
}
