//
//  View.swift
//  RSSNews
//
//  Created by Артём Горюнов on 28/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import Foundation
import UIKit

class NewsTableViewController : UITableViewController {
    
    let viewModel = NewsViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        tableView.delegate = nil
        viewModel.sections.asObservable()
            .bind(to: self.tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: viewModel.disposeBag)
        tableView.rx.setDelegate(self)
            .disposed(by: viewModel.disposeBag)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "identifier")
        viewModel.bindData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
 
}
