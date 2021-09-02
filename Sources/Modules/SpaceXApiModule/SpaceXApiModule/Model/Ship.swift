//
//  Ship.swift
//  SpaceXApiModule
//
//  Created by Will Nixon on 9/2/21.
//

import NetworkingService

public struct Ship: DTO {
  
  var legacyID: String
  var model: String
  var type: String
  var roles: [String]
  var shipClass: Int
  var massKg: Int
  var massLbs: Int
  var yearBuilt: Int
  var homePort: String
  var status: String
  var speedKn: Int
  var courseDeg: Int
  var latitude: Int
  var longitude: Int
  var link: String
  var image: String
  var name: String
  var active: Bool
  var launches: [String]
  var id: String
  
  public var description: String {
    return """
                ------------
                model = \(model)
                type = \(type)
                name = \(name)
                image = \(image)
                ------------
                """
  }
}
