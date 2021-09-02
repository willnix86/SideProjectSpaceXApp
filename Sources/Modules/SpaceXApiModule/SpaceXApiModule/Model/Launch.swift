//
//  Launch.swift
//  SpaceXApiModule
//
//  Created by Christian Slanzi on 02.08.21.
//

import NetworkingService

public struct Launch: DTO {
    
    var id: String
    var fairings: Fairings?
    var links: Links
    
    //Our Decoder is using convertFromSnakeCase decodingStrategy
    //so we can name the variable 'staticFireDateUtc' instead of 'static_fire_date_utc'
    var staticFireDateUtc: String
    
    var staticFireDateUnix: Int32
    var tbd: Bool
    var net: Bool
    var window: Int
    var rocket: String
    var success: Bool
    var details: String
    var ships: [String]
    var crew: [String]
    var capsules: [String]
    var payloads: [String]
    var launchpad: String
    var autoUpdate: Bool
    var launchLibraryId: String
    var flightNumber: Int
    var name: String
    var dateUtc: String
    var dateUnix: Int32
    var dateLocal: String
    var datePrecision: String
    var upcoming: Bool
    var cores: [Core]
 
    //TODO: complete the model
    
    public var description: String {
        return """
                ------------
                id = \(id)
                fairings = \(fairings)
                links = \(links)
                //TODO: complete the description
                ------------
                """
    }
}
