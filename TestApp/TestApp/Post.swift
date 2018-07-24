//
//  Post.swift
//  TestApp
//
//  Created by Santanu Koley on 23/07/18.
//  Copyright © 2018 Santanu Koley. All rights reserved.
//

import Foundation

struct Post: Codable {
    var status: String?
    var copyright: String?
    var num_results: Int?
    var results: [Results]?
}

struct Results: Codable {
    var url : String?
    var adx_keywords : String?
    var column : String?
    var section : String?
    var byline : String?
    var type : String?
    var title : String?
    var abstract : String?
    var published_date : String?
    var source : String?
    var id : Int?
    var asset_id : Int?
    var views : Int?
    var des_facet: [String]?
    var org_facet:[String]?
    var per_facet: [String]?
    var geo_facet: [String]?
    var media: [Media]

}

struct Media: Codable {
    var type: String?
    var subtype: String?
    var caption: String?
    var copyright: String?
    var approved_for_syndication: Int?
    var media_metadata: [MediaMetaData]?
}

struct MediaMetaData: Codable {
    var url: String?
    var format: String?
    var height: Int?
    var width: Int?
}









