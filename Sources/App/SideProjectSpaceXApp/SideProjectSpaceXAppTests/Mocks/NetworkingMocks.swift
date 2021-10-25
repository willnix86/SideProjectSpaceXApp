//
//  NetworkingMock.swift
//  SideProjectSpaceXAppTests
//
//  Created by Will Nixon on 10/21/21.
//

import Foundation
import NetworkingService
typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
}

protocol URLSessionProtocol {
    associatedtype dta: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dta
}

class MockHTTPClient: HTTPClient {
    private let session: URLSession

    var requestHttpHeaders: HTTPClientEntity
    
    var urlQueryParameters: HTTPClientEntity
    
    var httpBodyParameters: HTTPClientEntity
    
    init(session: URLSession) {
        self.session = session
        self.requestHttpHeaders = HTTPClientEntity()
        self.urlQueryParameters = HTTPClientEntity()
        self.httpBodyParameters = HTTPClientEntity()
    }
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionDataTaskProtocol

        func cancel() {
            wrapped.cancel()
        }
    }
    
    func makeRequest(toURL url: URL, withHttpMethod httpMethod: HTTPMethod, completion: @escaping (HTTPClientResult) -> Void) -> HTTPClientTask {
        makeRequest(toURL: url, withHttpMethod: httpMethod, cachePolicy: .useProtocolCachePolicy
                            , timeoutInterval: 30, completion: completion)
        
    }
    
    func makeRequest(toURL url: URL, withHttpMethod httpMethod: HTTPMethod, cachePolicy: NSURLRequest.CachePolicy, timeoutInterval: TimeInterval, completion: @escaping (HTTPClientResult) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { (data, response, error) in
            completion(HTTPClientResult(withData: data,
                               response: HTTPClientResponse(fromURLResponse: response),
                               error: error))
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
    
    func getData(fromURL url: URL, completion: @escaping (Data?) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { completion(nil); return }
            completion(data)
        }

        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}
