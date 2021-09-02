//
//  Core.swift
//  SpaceXApiModule
//
//  Created by Will Nixon on 9/2/21.
//

import NetworkingService

public struct Core: DTO {
  
  var core: String
  var flight: Int
  var block: Int
  var gridfins: Bool
  var legs: Bool
  var reused: Bool
  var landingAttempt: Bool
  var landingSuccess: Bool
  var landingType: String
  var landpad: String
  
  public var description: String {
    return """
                ------------
                core = \(core)
                flight = \(flight)
                landingSuccess = \(landingSuccess)
                landingType = \(landingType)
                ------------
                """
  }
}
