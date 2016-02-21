//
//  TVFeedsModel.swift
//  SeasonsDB
//
//  Created by Parth Adroja on 2/21/16.
//  Copyright © 2016 Parth Adroja. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class TVFeedsModel: Mappable {
    
    var arrEntry : [EpisodeDetails]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        arrEntry <- map["entry"]
    }
    
}

class EpisodeDetails: Mappable {
    
    var imName : String?
    var imImageHigh : String?
    var summary : String?
    var imPrice : String?
    var rights : String?
    var imArtist : String?
    var imReleaseDate : NSDate?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        imName <- map["im:name.label"]
        imImageHigh <- map["im:image.2.label"]
        summary <- map["summary.label"]
        imPrice <- map["im:price.label"]
        rights <- map["rights.label"]
        imArtist <- map["im:artist.label"]
        imReleaseDate <- (map["im:releaseDate.label"], DateTransform())
    }
}