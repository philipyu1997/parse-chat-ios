//
//  ChatCell.swift
//  ParseChat
//
//  Created by Philip Yu on 5/8/19.
//  Copyright © 2019 Philip Yu. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = false
        
        // Current user
        messageLabel.sizeToFit()
        bubbleView.sizeToFit()
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        bubbleView.backgroundColor = .systemGreen
        messageLabel.textColor = UIColor.white
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
}
