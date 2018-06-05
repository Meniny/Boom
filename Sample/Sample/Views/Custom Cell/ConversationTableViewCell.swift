//
//  ConversationTableViewCell.swift
//  Sample
//
//  Created by 李二狗 on 2018/6/4.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import UIKit
import Boom

class ConversationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbale: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLbale.font = UIFont.boldSystemFont(ofSize: 20)
        titleLbale.textColor = UIColor.darkText
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.textColor = UIColor.lightGray
    }
    
}

extension ConversationTableViewCell {
    static var reuseIdentifier: String {
        return "ConversationTableViewCell"
    }
    
    static var registerAsClass: Bool {
        return false
    }
}
