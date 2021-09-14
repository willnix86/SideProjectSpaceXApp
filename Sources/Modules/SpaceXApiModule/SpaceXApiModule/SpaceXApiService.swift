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
  
  //MARK: Launches
  
  //GET https://api.spacexdata.com/v4/launches/latest
  func getLatestLaunch(completion: @escaping (Swift.Result<Launch, ServiceError>)->Void) -> HTTPClientTask
  
  //GET https://api.spacexdata.com/v4/launches/next
  func getNextLaunch(completion: @escaping (Swift.Result<Launch, ServiceError>)->Void) -> HTTPClientTask
  
  //GET https://api.spacexdata.com/v4/launches/upcoming
  func getUpcomingLaunches(completion: @escaping (Swift.Result<[Launch], ServiceError>)->Void) -> HTTPClientTask
  
  //GET https://api.spacexdata.com/v4/launches/past
  func getPastLaunches(completion: @escaping (Swift.Result<[Launch], ServiceError>)->Void) -> HTTPClientTask
  
  
  //MARK: Ships
  
  //GET https://api.spacexdata.com/v4/ships
  func getShips(completion: @escaping (Swift.Result<[Ship], ServiceError>)->Void) -> HTTPClientTask

  //GET https://api.spacexdata.com/v4/ships/$shipID
  func getShip(named shipID: String, completion: @escaping (Swift.Result<Ship, ServiceError>)->Void) -> HTTPClientTask
  
  
  //MARK: Rockets
  
  //GET https://api.spacexdata.com/v4/rockets
  func getRockets(completion: @escaping (Swift.Result<[Rocket], ServiceError>)->Void) -> HTTPClientTask
  
  //GET https://api.spacexdata.com/v4/rockets/$rocketID
  func getRocket(named rocketID: String, completion: @escaping (Swift.Result<Rocket, ServiceError>)->Void) -> HTTPClientTask
}
