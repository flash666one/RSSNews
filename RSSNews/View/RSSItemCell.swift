//
//  RSSItemCell.swift
//  RSSNews
//
//  Created by Артём Горюнов on 30/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//

import UIKit

class RSSItemCell: UITableViewCell {
    
    @IBOutlet weak var rssContentView: UIView!
    
    @IBOutlet weak var rssImageView: UIImageView!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var news: News! {
        didSet {
            guard let urlStr = news.enclosure else { return }
            guard let url = URL(string: urlStr) else {return}
            self.sourceLabel.text = news.author ?? "LENTA.RU"
            self.titleLabel.text = news.title
            self.descriptionLabel.text = news.description.replacingOccurrences(of: "^\\s*", with: "", options: .regularExpression)
            self.dateLabel.text = news.pubDate.toStr()
            self.rssImageView?.kf.setImage(with: url)
            self.descriptionLabel.isHidden = !self.news.isSelected
        }
    }
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rssContentView.layer.cornerRadius = 16
        rssContentView.layer.masksToBounds = false
        rssContentView.layer.shadowColor = UIColor.black.cgColor
        rssContentView.layer.shadowOpacity = 0.2
        rssContentView.layer.shadowOffset = .zero
        rssContentView.layer.shadowRadius = 5
        rssContentView.layer.shouldRasterize = true
        rssContentView.layer.rasterizationScale = 1
    }
    
}
