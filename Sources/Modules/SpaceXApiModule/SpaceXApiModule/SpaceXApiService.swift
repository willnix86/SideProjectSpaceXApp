//
//  SpaceXApiService.swift
//  SpaceXApiModule
//
//  Created by Christian Slanzi on 02.08.21.
//

import Foundation
import NetworkingService

public protocol SpaceXApiService {
    typealias ServiceError = NetworkingServiceError
    
    //GET https://api.spacexdata.com/v4/launches/latest
    func getLatestLaunch(completion: @escaping (Swift.Result<Launch, ServiceError>)->Void) -> HTTPClientTask
    
}
