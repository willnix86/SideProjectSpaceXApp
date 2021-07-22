//
//  ViewController.swift
//  SideProjectSpaceXApp
//
//  Created by Christian Slanzi on 20.07.21.
//

import UIKit
import NetworkingService

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemPink
        
        //standardGetUrlRequestWithJsonAnswer()
        
        networkingServiceSampleRequest()
    }
    
    func networkingServiceSampleRequest() {
        // Create URL
        let url = URL(string: "https://api.spotify.com/v1")
        guard let requestUrl = url else { fatalError() }
        let client = URLSessionHTTPClient(session: URLSession.shared)
        let task = client.makeRequest(toURL: requestUrl.appendingPathComponent("browse/new-releases"), withHttpMethod: .get) { [weak self] result in
                guard self != nil else { return }
                
            let result: Swift.Result<AlbumModel, NetworkingServiceError> = GenericDecoder.decodeResult(result: result)
            print(result)
        }
        print(task)
    }


    func standardGetUrlRequestWithJsonAnswer() {
        // Create URL
        let url = URL(string: "https://api.spotify.com/v1")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Set HTTP Request Header
        request.setValue("Bearer BQD8NtKU2MjsTOqup1RyScIvlmZoP_x53ZGabiRSHBGqvPIkRxE7dIU8IbUhsmeZPUkec8boXLr_gst5L-o", forHTTPHeaderField: "Authorization")
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                
                if let album = self.parseJSON(data: data) {
                    print("album href = \(album.href)")
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> AlbumModel? {
        
        var returnValue: AlbumModel?
        do {
            returnValue = try JSONDecoder().decode(AlbumModel.self, from: data)
        } catch {
            print("Error took place\(error.localizedDescription).")
        }
        
        return returnValue
    }
}

public struct AlbumModel: DTO {
    
    public var href: String

    public var description: String {
        return """
        ------------
        href = \(href)
        ------------
        """
    }
}
