//
//  MOCK_SideProjectSpaceXApiService.swift
//  SideProjectSpaceXAppTests
//
//  Created by Will Nixon on 10/21/21.
//

import Foundation
import NetworkingService
import SpaceXApiModule
import UIKit

class SpaceXApiServiceMock: SpaceXApiService {
    private let baseURL = URL(string:"https://api.spacexdata.com/v4")!
    private lazy var client: HTTPClient = {
        return MockHTTPClient(session: MockURLSession())
    }()
    
    private func loadJsonDataFromFile(_ path: String, completion: (HTTPClientResult?) -> Void) {
            if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
                do {
                    let data = try HTTPClientResult(withData: Data(contentsOf: fileUrl, options: []), response: nil, error: nil)
                    completion(data)
                } catch (let error) {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    
  func getLatestLaunch(completion: @escaping (Result<Launch, ServiceError>) -> Void) -> HTTPClientTask {
      let requestUrl = baseURL.appendingPathComponent("launches/latest")
      let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] _ in
          guard self != nil else { return }
      
          self!.loadJsonDataFromFile("singleLaunch") { data in
              guard data != nil else { return completion(.failure(.invalidData)) }
              let result: Swift.Result<Launch, NetworkingServiceError> = GenericDecoder.decodeResult(result: data!)
              print(result)
              completion(result)
          }
      }
      return task
  }

  func getNextLaunch(completion: @escaping (Result<Launch, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/next")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
          
        self!.loadJsonDataFromFile("singleLaunch") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            let result: Swift.Result<Launch, NetworkingServiceError> = GenericDecoder.decodeResult(result: data!)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getUpcomingLaunches(completion: @escaping (Result<[Launch], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/upcoming")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
        self!.loadJsonDataFromFile("upcomingLaunches") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            let result: Swift.Result<[Launch], NetworkingServiceError> = GenericDecoder.decodeResult(result: data!)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getPastLaunches(completion: @escaping (Result<[Launch], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/past")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
        self!.loadJsonDataFromFile("pastLaunches") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            let result: Swift.Result<[Launch], NetworkingServiceError> = GenericDecoder.decodeResult(result: data!)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getShips(completion: @escaping (Result<[Ship], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("ships")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
        self!.loadJsonDataFromFile("multipleShips") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            let result: Swift.Result<[Ship], NetworkingServiceError> = GenericDecoder.decodeResult(result: data!)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getShip(named shipID: String, completion: @escaping (Result<Ship, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("ships/\(shipID)")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
        self!.loadJsonDataFromFile("singleShip") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            let result: Swift.Result<Ship, NetworkingServiceError> = GenericDecoder.decodeResult(result: data!)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getRockets(completion: @escaping (Result<[Rocket], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("rockets")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
        self!.loadJsonDataFromFile("multipleRockets") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            let result: Swift.Result<[Rocket], NetworkingServiceError> = GenericDecoder.decodeResult(result: data!)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getRocket(named rocketID: String, completion: @escaping (Result<Rocket, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("rockets/\(rocketID)")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard self != nil else { return }
      
        self!.loadJsonDataFromFile("singleRocket") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            let result: Swift.Result<Rocket, NetworkingServiceError> = GenericDecoder.decodeResult(result: data!)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func downloadImage(from url: String, completion: @escaping (Data?) -> Void) -> HTTPClientTask {
    let task = client.getData(fromURL: URL(string: url)!) { [weak self] _ in
      guard self != nil else { return }
        let imageData = UIImage(named: "spaceX")?.pngData()
      completion(imageData)
    }
    return task
  }
}
