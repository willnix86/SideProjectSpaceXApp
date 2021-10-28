//
//  ViewController.swift
//  SideProjectSpaceXApp
//
//  Created by Christian Slanzi on 20.07.21.
//

import UIKit
import SpaceXApiModule

class HomeViewController: UIViewController {
    let viewModel: HomeViewModel
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    var collectionView: UICollectionView! = nil
    var nextLaunchDate: Date?

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        navigationItem.titleView?.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureCollectionView()
    configureDataSource()
  }
}

extension HomeViewController {
    func configureCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(HeroImageCell.self, forCellWithReuseIdentifier: HeroImageCell.reuseIdentifier)
        collectionView.register(TitleAnchorView.self,
                                forSupplementaryViewOfKind: HomeViewController.titleKind,
                                withReuseIdentifier: TitleAnchorView.reuseIdentifier)
        collectionView.register(CountdownAnchorView.self,
                                forSupplementaryViewOfKind: HomeViewController.coundownKind,
                                withReuseIdentifier: CountdownAnchorView.reuseIdentifier)
        self.collectionView = collectionView
    }
    
    func configureDataSource() {
    }
    
    func generateLayout() -> UICollectionViewLayout {
    }
}

extension HomeViewController: UICollectionViewDelegate {
}

