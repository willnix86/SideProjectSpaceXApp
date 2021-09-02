//
//  RemoteSpaceXApiService.swift
//  SpaceXApiModule
//
//  Created by Christian Slanzi on 02.08.21.
//

import Foundation
import NetworkingService

public class RemoteSpaceXApiService: SpaceXApiService {
  private var baseURL: URL
  private var client: HTTPClient
  
  public init(baseURL: URL, client: HTTPClient) {
      self.baseURL = baseURL
      self.client = client
  }
  
  public func getLatestLaunch(completion: @escaping (Result<Launch, ServiceError>) -> Void) -> HTTPClientTask {
      let requestUrl = baseURL.appendingPathComponent("launches/latest")
      let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
              guard self != nil else { return }
              
          let result: Swift.Result<Launch, NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
          print(result)
          completion(result)
      }
      return task
  }

  public func getNextLaunch(completion: @escaping (Result<Launch, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/next")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
      let result: Swift.Result<Launch, NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
      print(result)
      completion(result)
    }
    return task
  }
  
  public func getUpcomingLaunches(completion: @escaping (Result<[Launch], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/upcoming")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
      let result: Swift.Result<[Launch], NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
      print(result)
      completion(result)
    }
    return task
  }
  
  public func getPastLaunches(completion: @escaping (Result<[Launch], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/past")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
      let result: Swift.Result<[Launch], NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
      print(result)
      completion(result)
    }
    return task
  }
  
  public func getShips(completion: @escaping (Result<[Ship], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("ships")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
      let result: Swift.Result<[Ship], NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
      print(result)
      completion(result)
    }
    return task
  }
  
  public func getShip(named shipID: String, completion: @escaping (Result<Ship, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("ships/\(shipID)")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
      let result: Swift.Result<Ship, NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
      print(result)
      completion(result)
    }
    return task
  }
  
  public func getRockets(completion: @escaping (Result<[Rocket], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("rockets")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
      let result: Swift.Result<[Rocket], NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
      print(result)
      completion(result)
    }
    return task
  }
  
  public func getRocket(named rocketID: String, completion: @escaping (Result<Rocket, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("rockets/\(rocketID)")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
      let result: Swift.Result<Rocket, NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
      print(result)
      completion(result)
    }
    return task
  }
  
}
