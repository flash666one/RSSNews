//
//  GazetaNews.swift
//  RSSNews
//
//  Created by Артём Горюнов on 28/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import Foundation
import SWXMLHash


struct News : XMLIndexerDeserializable {
    
    var description: String
    var pubDate: Date
    var enclosure: String?
    var title : String
    var link : String?
    var guid : String?
    var author : String?
    var isSelected : Bool
    
    static func deserialize(_ node: XMLIndexer) throws -> News {
        return try News(
            description: node["description"].value(),
            pubDate: node["pubDate"].value(),
            enclosure: node["enclosure"].value(ofAttribute: "url"),
            title: node["title"].value(),
            link: node["link"].value(),
            guid: node["guid"].value(),
            author: node["author"].value(),
            isSelected: false
        )
    }
    
}

