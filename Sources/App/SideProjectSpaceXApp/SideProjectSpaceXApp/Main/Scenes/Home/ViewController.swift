//
//  ViewController.swift
//  SideProjectSpaceXApp
//
//  Created by Christian Slanzi on 20.07.21.
//

import UIKit
import SpaceXApiModule

class ViewController: UIViewController {
    
    private let service: SpaceXApiService
    
    private var latestLaunch: Launch?
    private var ships: [Ship]?
    private var rockets: [Rocket]?
    
    init(service: SpaceXApiService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    _ = service.getRockets { result in
        switch result {
        case let .failure(error):
            print(error)
        case let .success(rockets):
            self.rockets = rockets
        }
    }
    
    _ = service.getLatestLaunch(completion: { result in
        switch result {
        case .success(let launch):
            self.latestLaunch = launch
        case .failure(_):
            print("Failed to fetch latest launch")
        }
    })
    
    _ = service.getShips(completion: { result in
        switch result {
        case .success(let ships):
            self.ships = ships
        case .failure(_):
            print("Failed to fetch ships")
        }
    })
    
    
  }

}



