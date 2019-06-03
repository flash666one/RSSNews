//
//  RSSItemCell.swift
//  RSSNews
//
//  Created by Артём Горюнов on 30/05/2019.
//  Copyright © 2019 Артём Горюнов. All rights reserved.
//
import Foundation
import UIKit

class RSSItemCell: UITableViewCell {
    
    @IBOutlet weak var rssContentView: UIView!
    
    @IBOutlet weak var rssImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    
    var news: News! {
        didSet {
            guard let urlStr = news.enclosure else { return }
            guard let url = URL(string: urlStr) else {return}
            
            let firstAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .foregroundColor: UIColor.black
            ]
            
            let secondAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 17),
                .foregroundColor: UIColor.black
            ]
            
            let stringValue = NSMutableAttributedString(string: (news.author ?? "LENTA.RU") + "\n", attributes: firstAttributes)
            
            let description = news.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            
            let title = NSAttributedString(string: (news.title) + "\n", attributes: firstAttributes)
            let descAttributed = NSAttributedString(string: (description) + "\n", attributes: secondAttributes)
            let date = news.pubDate.toStr()
            let dateAttributed = NSAttributedString(string: (date) + "\n", attributes: secondAttributes)
            
            stringValue.append(title)
            if news.isSelected { stringValue.append(descAttributed) }

            stringValue.append(dateAttributed)
            self.titleLabel.attributedText = stringValue
            self.rssImageView?.kf.setImage(with: url)
            
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
        rssImageView.layer.cornerRadius = 16
        rssImageView.layer.masksToBounds = true
        rssImageView.layer.borderWidth = 1
        rssImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
