//
//  Links.swift
//  SpaceXApiModule
//
//  Created by Will Nixon on 9/2/21.
//

import NetworkingService

public struct Links: DTO {
  public var patch: Patch
  public var reddit: Reddit
  public var flickr: Flickr
  public var presskit: String?
  public var webcast: String?
  public var youtubeID: String?
  public var article: String?
  public var wikipedia: String?
    
  public var description: String {
    return """
                ------------
                Links
                ------------
                """
  }
}

//MARK: Patch
public struct Patch: DTO {
  
  public var small: String?
  public var large: String?
  
  public var description: String {
    return """
                ------------
                Patch
                ------------
                """
  }
}

//MARK: Flickr
public struct Flickr: DTO {
  
  public var small: [String]?
  public var original: [String]
  
  public var description: String {
    return """
                ------------
                original = \(original)
                ------------
                """
  }
}

//MARK: Reddit
public struct Reddit: DTO {
  
  public var campaign: String?
  public var launch: String?
  public var media: String?
  public var recovery: String?
  
  public var description: String {
    return """
                ------------
                Reddit
                ------------
                """
  }
}


