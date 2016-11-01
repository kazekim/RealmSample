//
//  Entry.swift
//  RealmSample
//
//  Created by Satoshi Nagasaka on 2015/05/13.
//  Copyright (c) 2015年 SatoshiN21. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class Entry : Object {
    
    dynamic var content : String = ""
    dynamic var link : String = ""
    dynamic var publishedDate : Date = Date()
    dynamic var title : String = ""
    dynamic var contentSnippet : String = ""
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    override class func primaryKey() -> String {
        return "link"
    }
}

extension Entry : Mappable {
    
    func mapping(map: Map) {
        content         <- map["content"]
        link            <- map["link"]
        publishedDate   <- (map["publishedDate"] , EntryDateTransform())
        title           <- map["title"]
        contentSnippet  <- map["contentSnippet"]
    }
}


class EntryDateTransform : DateTransform {
    override func transformFromJSON(_ value: Any?) -> Date? {
        if let dateStr = value as? String {
            return Date.dateWithString(
                dateStr,
                format: "E, dd MMM yyyy HH:mm:ss zzzz" ,
                locale : Locale(identifier: "en_US"))
        }
        return nil
    }
}
