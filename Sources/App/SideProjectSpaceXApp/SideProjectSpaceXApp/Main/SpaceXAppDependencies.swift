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
        
        setRootViewController(makeMainTabBarController())

    }
}

// MARK: - Tab Bar Controller
extension SpaceXAppDependencies {
    private func makeMainTabBarController() -> UIViewController {
        
        let homeVC = makeHomeViewController()
        let upcomingVC = makeUpcomingViewController()
        let profileVC = makeProfileViewController()
        
        let tabController = MainTabBarController(
            viewControllers: [homeVC, upcomingVC, profileVC])
        return tabController
    }
    
    private func makeHomeViewController() -> UIViewController {
        let vm = HomeViewModel(service: apiService)
        let vc = HomeViewController(viewModel: vm)
        vc.title = "Home"
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        return navigationController
    }
    
    private func makeUpcomingViewController() -> UIViewController {
        let vc = UpcomingViewController(service: apiService)
        vc.title = "Upcoming"
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.title = "Upcoming"
        navigationController.tabBarItem.image = UIImage(systemName: "paperplane")
        return navigationController
    }
    
    private func makeProfileViewController() -> UIViewController {
        let vc = UIViewController()
        vc.title = "Company"
        vc.view.backgroundColor = .systemBackground
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.title = "Company"
        navigationController.tabBarItem.image = UIImage(systemName: "building.2")
        return navigationController
    }
}
