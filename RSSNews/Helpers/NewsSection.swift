//
//  NewsSection.swift
//  RSSNews
//
//  Created by Артём Горюнов on 28/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import Foundation
import RxCocoa
import RxDataSources
import RxSwift


extension String {
    public typealias Identity = String
    var identity: Identity { return self }
}


extension News: IdentifiableType, Equatable {
    
    typealias Identity = String
    
    var identity : Identity { return title }
    
    static func ==(lhs: News, rhs: News) -> Bool {
        return lhs.title == rhs.title
    }
    
}

struct NewsSectionModel {
    var header: String
    var items: [Item]
}

extension NewsSectionModel : AnimatableSectionModelType {
    
    typealias Item = News
    
    var identity: String {
        return header
    }
    
    init(original: NewsSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
    
}
