//
//  Links.swift
//  SpaceXApiModule
//
//  Created by Will Nixon on 9/2/21.
//

import NetworkingService

public struct Links: DTO {
  var patch: Patch
  var reddit: Reddit
  var flickr: Flickr
  var presskit: String?
  var webcast: String?
  var youtubeID: String?
  var article: String?
  var wikipedia: String?
    
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
  
  var small: String?
  var large: String?
  
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
  
  var small: [String]?
  var original: [String]
  
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
  
  var campaign: String?
  var launch: String?
  var media: String?
  var recovery: String?
  
  public var description: String {
    return """
                ------------
                Reddit
                ------------
                """
  }
}


