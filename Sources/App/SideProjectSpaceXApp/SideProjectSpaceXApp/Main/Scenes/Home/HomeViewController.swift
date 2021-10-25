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
    var nextLaunchDate: Date?

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
  }
}



