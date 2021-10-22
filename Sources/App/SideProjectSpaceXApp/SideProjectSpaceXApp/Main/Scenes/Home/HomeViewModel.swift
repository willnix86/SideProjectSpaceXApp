//
//  HomeModel.swift
//  SideProjectSpaceXApp
//
//  Created by Will Nixon on 10/21/21.
//

import Foundation
import SpaceXApiModule

protocol NextLaunchProtocol {
    func getNextLaunch(completion: @escaping (Launch?) -> Void)
}

class HomeViewModel {
    let service: SpaceXApiService
    var nextLaunch: Launch?
    var nextLaunchDate: Date?

    init(service: SpaceXApiService) {
        self.service = service
    }
}

extension HomeViewModel: NextLaunchProtocol {
    func getNextLaunch(completion: @escaping (Launch?) -> Void) {
        _ = service.getNextLaunch { result in
            switch result {
            case .success(let launch):
                self.nextLaunch = Launch(name: launch.name, flightNumber: launch.flightNumber, dateLocal: launch.dateLocal, datePrecision: launch.datePrecision, smallPatch: launch.links.patch.small)
                completion(self.nextLaunch)
            case .failure(_):
                print("Failed to fetch ships")
                completion(nil)
            }
        }
    }
    
    func convertToDateFrom(_ dateString: String) {
        if let date = dateString.toDate {
            self.nextLaunchDate = date
        }
    }
}

extension String {
    var toDate: Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: self)
    }
}
