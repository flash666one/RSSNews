//
//  View.swift
//  RSSNews
//
//  Created by Артём Горюнов on 28/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class NewsTableViewController : UITableViewController {

    let viewModel = NewsViewModel()
    
    let identifier = "RSSItemCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "RSS Feed"
        
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "RSSItemCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl!
        
        refreshControl.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        viewModel.bindData()
        viewModel.observableNews.bind(to: tableView.rx.items(cellIdentifier: identifier, cellType: RSSItemCell.self)) { ( ip, item, cell) in
            cell.news = item
            cell.contentView.backgroundColor = self.tableView.backgroundColor
        }.disposed(by: viewModel.disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { (ip) in
            self.viewModel.changeValue(ip: ip)
            self.tableView.scrollToRow(at: ip, at: .top, animated: false)
        }).disposed(by: viewModel.disposeBag)

        tableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
        
    }
    
    @objc func refresh() {
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let self = self else { return }
            self.viewModel.bindData()
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
            }
        }
    }
}

extension NewsTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)

        let item = viewModel.observableNews.value[indexPath.row]
        let descriptionText = item.description.replacingOccurrences(of: "<[^>]+>s", with: "", options: .regularExpression)
        let size = CGSize(width: view.frame.width - 32, height: 1000)

        let titleFrame = NSString(string: item.title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)], context: nil)
        let sourceFrame = NSString(string: item.author ?? "").boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)], context: nil)
        let descFrame = NSString(string: descriptionText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], context: nil)
        let dateFrame = NSString(string: item.pubDate.toStr()).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], context: nil)


        let imageViewHeight = ((self.view.frame.width / 3) * 2) + 48
        
        let descHeight = item.isSelected ? descFrame.height : 0

        let height = titleFrame.height
            + sourceFrame.height
            + dateFrame.height
            + descHeight
            + imageViewHeight

        return height
        
    }
}
