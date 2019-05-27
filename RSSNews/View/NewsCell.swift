//
//  NewsCell.swift
//  RSSNews
//
//  Created by Артём Горюнов on 28/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    let iv: UIImageView = {
        let height: CGFloat = 150
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: height, height: height))
        iv.layer.cornerRadius = height / 2
        return iv
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
