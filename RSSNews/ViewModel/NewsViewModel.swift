//
//  NewsViewModel.swift
//  RSSNews
//
//  Created by Артём Горюнов on 28/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import FeedKit

class NewsViewModel  {
    
    let disposeBag = DisposeBag()
    
    var observableNews = BehaviorRelay<[News]>(value: [])
    
    var asdq = Variable<[News]>([])
    
    func changeValue(ip: IndexPath) {
        var news = observableNews.value
        news[ip.row].isSelected = !news[ip.row].isSelected
        self.observableNews.accept(news)
    }
    
    func bindData () {

        Observable.combineLatest(
            NetworkManager.getNews(source: .gazeta),
            NetworkManager.getNews(source: .lenta)
            ).map {  gazeta , lenta   in
                let array = [gazeta,lenta].flatMap({ $0 })
                let sorted = array.sorted(by: {$0.pubDate < $1.pubDate })
                return sorted
            }.bind(to: observableNews)
            .disposed(by: disposeBag)
        
    }
    
    
}

