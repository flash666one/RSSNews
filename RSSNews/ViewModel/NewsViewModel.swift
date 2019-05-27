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
import RxDataSources

class NewsViewModel  {
    
    let disposeBag = DisposeBag()
    var sections = Variable([NewsSectionModel]())
    
    let dataSource = RxTableViewSectionedAnimatedDataSource<NewsSectionModel>(configureCell: { (ds, tw, ip, item) in
        
        let cell = UITableViewCell(style: .value2, reuseIdentifier: "identifier")
//        cell.textLabel?.text = item.title
        cell.textLabel?.text = "\(item.pubDate)"
//        cell.textLabel?.text = item.title
        return cell
    })
    
    func bindData () {
        Observable.merge(
            NetworkManager.getNews(rss: .gazeta),
            NetworkManager.getNews(rss: .lenta)
            ).map({ $0.sorted(by: {$0.pubDate < $1.pubDate })}).subscribe(onNext: { (news) in
                self.sections.value = [NewsSectionModel(header: "Title", items: news)]
            }, onCompleted: {
                print("completed")
            }).disposed(by: disposeBag)
    }
    
    
}

