//
//  Extensions.swift
//  RSSNews
//
//  Created by Артём Горюнов on 28/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import Foundation
import SWXMLHash

extension Date: XMLElementDeserializable, XMLAttributeDeserializable {
    public static func deserialize(_ element: XMLElement) throws -> Date {
        let date = stringToDate(element.text)
        
        guard let validDate = date else {
            throw XMLDeserializationError.typeConversionFailed(type: "Date", element: element)
        }
        
        return validDate
    }
    
    public static func deserialize(_ attribute: XMLAttribute) throws -> Date {
        let date = stringToDate(attribute.text)
        
        guard let validDate = date else {
            throw XMLDeserializationError.attributeDeserializationFailed(type: "Date", attribute: attribute)
        }
        
        return validDate
    }
    
    private static func stringToDate(_ dateAsString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return dateFormatter.date(from: dateAsString)
    }
    
    func toStr() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .medium
        return formatter.string(from: self)
        
    }
    
}
