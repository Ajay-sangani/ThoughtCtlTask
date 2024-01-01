//
//  ViewController.swift
//  ThoughtCtlTask
//
//  Created by Apple on 29/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var listButton: UIButton!
    
    fileprivate var viewModel = DataViewModel()
    
    fileprivate var leftPadding: CGFloat {
        return 11
    }
    
    fileprivate var contentInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: leftPadding)
    }
    
    fileprivate var cellSize: CGSize {
        let width = viewModel.isGridMode ? (collectionView.frame.size.width - (leftPadding * 2)) / 3 : collectionView.frame.size.width - (leftPadding * 2)
        return CGSize(width: width, height: 170)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    //Basic UI Configurations
    func setupUI() {
        collectionView.contentInset = contentInset
        collectionView.register(UINib(nibName: ImageCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        setISGridMode(isGridMode: viewModel.isGridMode)
        listButton.circularView()
    }
    
    //MARK: tappedListButton
    @IBAction func tappedListButton(_ sender: UIButton) {
        viewModel.isGridMode = !viewModel.isGridMode
        setISGridMode(isGridMode: viewModel.isGridMode)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // Call the function to fetch data
            viewModel.fetchImagesFromImgur(for: searchText)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {   // Hide content
            searchBar.resignFirstResponder() // Dismiss the keyboard if it's open
            viewModel.searchResults = []
            collectionView.reloadData()
        }
    }
    
    func setISGridMode(isGridMode: Bool) {
        viewModel.isGridMode = isGridMode
        listButton.setTitle("", for: .normal)
        listButton.setImage(UIImage(named: viewModel.isGridMode ? "list_icon" : "grid_icon"), for: .normal)
        collectionView.reloadData()
    }
}

// Implement UICollectionViewDataSource and UICollectionViewDelegate methods
// Configure cells to display title, date, additional images count, and images
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        if let object = viewModel.searchResults[indexPath.row] as? ImgurImage {
            cell.configureData(imageData: object)
        }
        return cell
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController {
    func setupViewModel() {
        viewModel.updatedOnImageList = {message, error in
            //self.updateUI()
            if error == nil {
                self.collectionView.reloadData()
            }
        }
    }
}
