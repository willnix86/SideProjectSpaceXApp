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
        return MockHTTPClient(session: URLSession.shared)
    }()
    
    private var mockResponse = HTTPClientResponse(fromURLResponse: URLResponse())
    
  func getLatestLaunch(completion: @escaping (Result<LaunchDTO, ServiceError>) -> Void) -> HTTPClientTask {
      let requestUrl = baseURL.appendingPathComponent("launches/latest")
      let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] _ in
          guard let self = self else { return }
      
          self.loadJsonDataFromFile("singleLaunch") { data in
              guard data != nil else { return completion(.failure(.invalidData)) }
              self.mockResponse.statusCode = 200
              let mockResult = HTTPClientResult(withData: data!, response: self.mockResponse, error: nil)
              let result: Swift.Result<LaunchDTO, NetworkingServiceError> = GenericDecoder.decodeResult(result: mockResult)
              print(result)
              completion(result)
          }
      }
      return task
  }

  func getNextLaunch(completion: @escaping (Result<LaunchDTO, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/next")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard let self = self else { return }
          
        self.loadJsonDataFromFile("singleLaunch") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            self.mockResponse.statusCode = 200
            let mockResult = HTTPClientResult(withData: data!, response: self.mockResponse, error: nil)
            let result: Swift.Result<LaunchDTO, NetworkingServiceError> = GenericDecoder.decodeResult(result: mockResult)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getUpcomingLaunches(completion: @escaping (Result<[LaunchDTO], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/upcoming")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard let self = self else { return }
      
        self.loadJsonDataFromFile("upcomingLaunches") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            self.mockResponse.statusCode = 200
            let mockResult = HTTPClientResult(withData: data!, response: self.mockResponse, error: nil)
            let result: Swift.Result<[LaunchDTO], NetworkingServiceError> = GenericDecoder.decodeResult(result: mockResult)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getPastLaunches(completion: @escaping (Result<[LaunchDTO], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("launches/past")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard let self = self else { return }
      
        self.loadJsonDataFromFile("pastLaunches") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            self.mockResponse.statusCode = 200
            let mockResult = HTTPClientResult(withData: data!, response: self.mockResponse, error: nil)
            let result: Swift.Result<[LaunchDTO], NetworkingServiceError> = GenericDecoder.decodeResult(result: mockResult)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getShips(completion: @escaping (Result<[ShipDTO], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("ships")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard let self = self else { return }
      
        self.loadJsonDataFromFile("multipleShips") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            self.mockResponse.statusCode = 200
            let mockResult = HTTPClientResult(withData: data!, response: self.mockResponse, error: nil)
            let result: Swift.Result<[ShipDTO], NetworkingServiceError> = GenericDecoder.decodeResult(result: mockResult)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getShip(named shipID: String, completion: @escaping (Result<ShipDTO, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("ships/\(shipID)")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard let self = self else { return }
      
        self.loadJsonDataFromFile("singleShip") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            self.mockResponse.statusCode = 200
            let mockResult = HTTPClientResult(withData: data!, response: self.mockResponse, error: nil)
            let result: Swift.Result<ShipDTO, NetworkingServiceError> = GenericDecoder.decodeResult(result: mockResult)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getRockets(completion: @escaping (Result<[RocketDTO], ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("rockets")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard let self = self else { return }
      
        self.loadJsonDataFromFile("multipleRockets") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            self.mockResponse.statusCode = 200
            let mockResult = HTTPClientResult(withData: data!, response: self.mockResponse, error: nil)
            let result: Swift.Result<[RocketDTO], NetworkingServiceError> = GenericDecoder.decodeResult(result: mockResult)
            print(result)
            completion(result)
        }
    }
    return task
  }
  
  func getRocket(named rocketID: String, completion: @escaping (Result<RocketDTO, ServiceError>) -> Void) -> HTTPClientTask {
    let requestUrl = baseURL.appendingPathComponent("rockets/\(rocketID)")
    let task = client.makeRequest(toURL: requestUrl, withHttpMethod: .get) { [weak self] result in
      guard let self = self else { return }
      
        self.loadJsonDataFromFile("singleRocket") { data in
            guard data != nil else { return completion(.failure(.invalidData)) }
            self.mockResponse.statusCode = 200
            let mockResult = HTTPClientResult(withData: data!, response: self.mockResponse, error: nil)
            let result: Swift.Result<RocketDTO, NetworkingServiceError> = GenericDecoder.decodeResult(result: mockResult)
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
    
    private func loadJsonDataFromFile(_ path: String, completion: (Data?) -> Void) {
        if let fileUrl = Bundle(for: type(of: self )).url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data)
            } catch (let error) {
                print(error.localizedDescription)
                completion(nil)
            }
        } else {
            print("FILE NOT FOUND")
        }
    }
}
