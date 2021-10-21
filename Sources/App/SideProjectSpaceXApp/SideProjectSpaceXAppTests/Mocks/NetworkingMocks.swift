//
//  NetworkingMock.swift
//  SideProjectSpaceXAppTests
//
//  Created by Will Nixon on 10/21/21.
//

import Foundation
import NetworkingService

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithURL(_ url: URL, completion: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTaskWithURL(_ url: URL, completion: @escaping DataTaskResult)
          -> URLSessionDataTaskProtocol
        {
            dataTask(with: url, completionHandler: completion) as URLSessionDataTaskProtocol
        }
}

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()

    func dataTaskWithURL(_ url: URL, completion: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return nextDataTask
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    private (set) var cancelWasCalled = false

    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        cancelWasCalled = true
    }
}

class MockHTTPClient: HTTPClient {
    let session: URLSessionProtocol
    var requestHttpHeaders: HTTPClientEntity
    var urlQueryParameters: HTTPClientEntity
    var httpBodyParameters: HTTPClientEntity
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionDataTaskProtocol
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
   init(session: URLSessionProtocol) {
        self.requestHttpHeaders = HTTPClientEntity()
        self.urlQueryParameters = HTTPClientEntity()
        self.httpBodyParameters = HTTPClientEntity()
        self.session = session
    }
    
    func makeRequest(toURL url: URL,
                            withHttpMethod httpMethod: HTTPMethod,
                            completion: @escaping (HTTPClientResult) -> Void)  -> HTTPClientTask {
        
        makeRequest(toURL: url, withHttpMethod: httpMethod, cachePolicy: .useProtocolCachePolicy
                    , timeoutInterval: 30, completion: completion)

    }
    
    func makeRequest(toURL url: URL,
                            withHttpMethod httpMethod: HTTPMethod,
                            cachePolicy: NSURLRequest.CachePolicy,
                            timeoutInterval: TimeInterval,
                            completion: @escaping (HTTPClientResult) -> Void)  -> HTTPClientTask {
        
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            
            completion(HTTPClientResult(withData: data,
                               response: HTTPClientResponse(fromURLResponse: response),
                               error: error))
        }
        
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)

    }
    
    func getData(fromURL url: URL, completion: @escaping (Data?) -> Void) -> HTTPClientTask {
                
        let task = session.dataTaskWithURL(url) { (data, response, error) in
            
            guard let data = data else { completion(nil); return }
            completion(data)
        }
        
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }

}


