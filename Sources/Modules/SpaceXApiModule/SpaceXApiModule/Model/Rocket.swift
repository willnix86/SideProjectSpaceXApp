//
//  Rocket.swift
//  SpaceXApiModule
//
//  Created by Will Nixon on 9/2/21.
//

import NetworkingService

public struct Rocket: DTO {
  
  var id: Int
  var active: Bool
  var stages: Int
  var boosters: Int
  var costPerLaunch: Int
  var successRatePct: Int
  var firstFlight: String
  var country: String
  var company: String
  var height: Diameter
  var diameter: Diameter
  var mass: Mass
  var payloadWeights: [PayloadWeight]
  var firstStage: FirstStage
  var secondStage: SecondStage
  var engines: Engines
  var landingLegs: LandingLegs
  var wikipedia: String
  var rocketDescription: String
  var rocketID: String
  var rocketName: String
  var rocketType: String

  
  public var description: String {
    return """
                ------------
                rocketID = \(rocketID)
                rocketName = \(rocketName)
                rocketType = \(rocketType)
                ------------
                """
  }
}

// MARK: - Diameter
struct Diameter: DTO {
  var meters: Double
  var feet: Double
  
  public var description: String {
    return """
                ------------
                meters = \(meters)
                feet = \(feet)
                ------------
                """
  }
}

// MARK: - Engines
struct Engines: DTO {
  var number: Int
  var type: String
  var version: String
  var layout: String
  var engineLossMax: Int
  var propellant1: String
  var propellant2: String
  var thrustSeaLevel: Thrust
  var thrustVacuum: Thrust
  var thrustToWeight: Double
  
  public var description: String {
    return """
                ------------
                number = \(number)
                type = \(type)
                ------------
                """
  }
}

// MARK: - Thrust
struct Thrust: DTO {
  var kN: Int
  var lbf: Int
  
  public var description: String {
    return """
                ------------
                kN = \(kN)
                lbf = \(lbf)
                ------------
                """
  }
}

// MARK: - FirstStage
struct FirstStage: DTO {
  var reusable: Bool
  var engines: Int
  var fuelAmountTons: Int
  var burnTimeSEC: Int
  var thrustSeaLevel: Thrust
  var thrustVacuum: Thrust
  
  public var description: String {
    return """
                ------------
                engines = \(engines)
                reusable = \(reusable)
                fuelAmountTons = \(fuelAmountTons)
                burnTimeSEC = \(burnTimeSEC)
                thrustSeaLevel = \(thrustSeaLevel)
                thrustVacuum = \(thrustVacuum)
                ------------
                """
  }
}

// MARK: - LandingLegs
struct LandingLegs: DTO {
  var number: Int
  var material: String
  
  public var description: String {
    return """
                ------------
                number = \(number)
                material = \(material)
                ------------
                """
  }
}

// MARK: - Mass
struct Mass: DTO {
  var kg: Int
  var lb: Int
  
  public var description: String {
    return """
                ------------
                kg = \(kg)
                lb = \(lb)
                ------------
                """
  }
}

// MARK: - PayloadWeight
struct PayloadWeight: DTO {
  var id: String
  var name: String
  var kg: Int
  var lb: Int
  
  public var description: String {
    return """
                ------------
                id = \(id)
                name = \(name)
                kg = \(kg)
                lb = \(lb)
                ------------
                """
  }
}

// MARK: - SecondStage
struct SecondStage: DTO {
  var engines: Int
  var fuelAmountTons: Int
  var burnTimeSEC: Int
  var thrust: Thrust
  var payloads: Payloads
  
  public var description: String {
    return """
                ------------
                engines = \(engines)
                fuelAmountTons = \(fuelAmountTons)
                burnTimeSEC = \(burnTimeSEC)
                thrust = \(thrust)
                payloads = \(payloads)
                ------------
                """
  }
}

// MARK: - Payloads
struct Payloads: DTO {
  var option1: String
  var option2: String
  var compositeFairing: CompositeFairing
  
  public var description: String {
    return """
                ------------
                option1 = \(option1)
                option2 = \(option2)
                compositeFairing = \(compositeFairing)
                ------------
                """
  }
}

// MARK: - CompositeFairing
struct CompositeFairing: DTO {
  var height: Diameter
  var diameter: Diameter
  
  public var description: String {
    return """
                ------------
                height = \(height)
                diameter = \(diameter)
                ------------
                """
  }
}
