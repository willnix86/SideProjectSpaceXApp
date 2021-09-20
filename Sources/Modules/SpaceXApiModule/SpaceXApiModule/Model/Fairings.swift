//
//  Fairings.swift
//  SpaceXApiModule
//
//  Created by Will Nixon on 9/2/21.
//

import NetworkingService

public struct Fairings: DTO {
  
  var resued: Bool?
  var recoveryAttempt: Bool?
  var recovered: Bool?
  var ships: [String]
  
  public var description: String {
    return """
              ------------
                ships = \(ships)
              ------------
              """
  }
}
