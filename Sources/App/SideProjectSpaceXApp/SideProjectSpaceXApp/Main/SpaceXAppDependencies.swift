//
//  SpaceXAppDependencies.swift
//  SideProjectSpaceXApp
//
//  Created by Christian Slanzi on 15.09.21.
//

import Foundation
import UIKit
import NetworkingService
import SpaceXApiModule

class SpaceXAppDependencies {
    var window: UIWindow?
    
    private lazy var client: HTTPClient = {
        return URLSessionHTTPClient(session: URLSession.shared)
    }()
    
    private lazy var apiService: SpaceXApiService = {
        return RemoteSpaceXApiService(baseURL: URL(string:"https://api.spacexdata.com/v4")!,
                                      client: client)
    }()
    
    private init(){
        
    }
    
    static let shared = SpaceXAppDependencies()
    
    internal func setRootViewController(_ viewController: UIViewController) {
        window?.rootViewController = viewController
    }
    
    public func setScene(_ scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.makeKeyAndVisible()
    }
    
    public func start() {
        
        setRootViewController(ViewController(service: apiService))

    }
}
