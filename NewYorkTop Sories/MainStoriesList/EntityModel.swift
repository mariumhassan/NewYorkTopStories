//
//  EntityModel.swift
//
//  Created by Marium Hassan on 09.08.22.
//

import UIKit

struct EntityModel: Codable {
    var results: [StoryModel]
}

struct StoryModel: Codable {
    var url: String
    var id: Int
    var published_date: String
    var byline: String
    var title: String
    var abstract: String
    var media: [Media]
}

struct Media: Codable {
    var metaData: [MediaMetaData]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "media-metadata"
    }
}

struct MediaMetaData: Codable {
    var url: String
    var format: String
    var height: Int
    var width: Int
}

struct MainStoryListModel {
    var url: String
    var title: String
    var author: String
    var abstract: String
    var media: [MediaMetaData]?
}




