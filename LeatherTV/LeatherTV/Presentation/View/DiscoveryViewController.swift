//
//  DiscoveryViewController.swift
//  LeatherTV
//
//  Created by Ammad Akhtar on 28/11/2021.
//

import UIKit

final class DiscoveryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DiscoveryViewModelDelegate {
    
    // MARK: - Variables
    
    private let transitionManger = CardTransitionManager()

    private var viewModel: DiscoveryViewModel
    private let cellId = "cellId"
  
    private lazy var searchField: UISearchTextField = {
        var searchField = UISearchTextField()
        searchField.placeholder = "Search"
        searchField.font = UIFont.boldSystemFont(ofSize: 22)
        return searchField
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 180, width: view.frame.width, height: 200), collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    // MARK: - Lifecycle

    init(viewModel: DiscoveryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupConstraints()
        setupCollectionView()
        setupBndings()
        viewModel.delegate = self
        viewModel.fetchShowsList()
    }

    // MARK: - Private Functions

    private func setupBndings() {
        //viewModel.category.observe(on: self, observerBlock: {[weak self] _ in self?.collectionView.reloadData()})
    }
    
    private func setupCollectionView() {
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        view.isOpaque = true
        
        [searchField, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16.0),
            searchField.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16.0),
            searchField.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16),
        ])
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTrackCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: ShowCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ShowCollectionViewCell, let track = viewModel.getTrackForIndex(index: indexPath.item) {
            cell.configure(track: track)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 3, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let track = viewModel.getTrackForIndex(index: indexPath.item) else { return }
        let detailViewController = DetailViewController(track: track)
        detailViewController.modalPresentationStyle = .overCurrentContext
        detailViewController.transitioningDelegate = transitionManger
        self.present(detailViewController, animated: true, completion: nil)
    }
    
    func selectedCellShowView() -> ShowView? {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return nil }

        let cell = collectionView.cellForItem(at: indexPath) as! ShowCollectionViewCell
        let showView = cell.showView
        showView.configure()
        return showView
    }
    
    // MARK: - DiscoveryViewModelDelegate
    
    func didFetchShows() {
        collectionView.reloadData()
    }
}

