//
//  ViewController.swift
//  SideProjectSpaceXApp
//
//  Created by Christian Slanzi on 20.07.21.
//

import UIKit
import NetworkingService
import SpaceXApiModule

class ViewController: UIViewController {
    
    private var latestLaunch: Launch?
    private var service: SpaceXApiService = RemoteSpaceXApiService(baseURL: URL(string:"https://api.spacexdata.com/v4")!,
                                                                   client: URLSessionHTTPClient(session: URLSession.shared))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        _ = service.getLatestLaunch { result in
            switch result {
            case let .failure(error):
                print(error)
            case let .success(launch):
                self.latestLaunch = launch
            }
        }
    }
    
}



