//
//  NetworkManager.swift
//  RSSNews
//
//  Created by Артём Горюнов on 27/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SWXMLHash

class NetworkManager {
    
    enum Source {
        case lenta, gazeta
    }
    
    static func getNews (source : Source) -> Observable<[News]> {
        
        let url: String = {
            switch source {
            case .gazeta :
                return "https://www.gazeta.ru/export/rss/lenta.xml"
            case .lenta :
                return "https://lenta.ru/rss"
            }
        }()
        
        return Observable<[News]>.create({ (observer) in
            let request = Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .responseData(queue: DispatchQueue.global(qos: .background), completionHandler: { (response) in
                    switch response.result {
                    case .success(let data):
                        do {
                            let xml = SWXMLHash.parse(data)
                            let newsArray:  [News] = try xml["rss"]["channel"]["item"].value()
                            observer.onNext(newsArray)
                            observer.onCompleted()
                        } catch (let error) {
                            observer.onError(error)
                            
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            return Disposables.create {
                request.cancel()
            }
        })
    }
    
}
