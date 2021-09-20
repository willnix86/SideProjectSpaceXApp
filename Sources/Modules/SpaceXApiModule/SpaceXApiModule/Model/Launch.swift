//
//  Launch.swift
//  SpaceXApiModule
//
//  Created by Christian Slanzi on 02.08.21.
//

import NetworkingService

public struct Launch: DTO {
    
  public var id: String
  public var fairings: Fairings?
  public var links: Links
    
    //Our Decoder is using convertFromSnakeCase decodingStrategy
    //so we can name the variable 'staticFireDateUtc' instead of 'static_fire_date_utc'
  public var staticFireDateUtc: String?
    
  public var staticFireDateUnix: Int32?
  public var tbd: Bool
  public var net: Bool
  public var window: Int?
  public var rocket: String
  public var success: Bool?
  public var details: String?
  public var ships: [String]
  public var crew: [String]
  public var capsules: [String]
  public var payloads: [String]
  public var launchpad: String
  public var autoUpdate: Bool
  public var launchLibraryId: String?
  public var flightNumber: Int
  public var name: String
  public var dateUtc: String
  public var dateUnix: Int32
  public var dateLocal: String
  public var datePrecision: String
  public var upcoming: Bool
  public var cores: [Core]
   
  public var description: String {
      return """
              ------------
              id = \(id)
              links = \(links)
              ------------
              """
  }
}
