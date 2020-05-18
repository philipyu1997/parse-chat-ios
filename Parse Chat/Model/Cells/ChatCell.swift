//
//  ChatCell.swift
//  ParseChat
//
//  Created by Philip Yu on 5/8/19.
//  Copyright © 2019 Philip Yu. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatMessageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        bubbleView.sizeToFit()
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        bubbleView.backgroundColor = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0) // Red
//        bubbleView.backgroundColor = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0) // Orange
//        bubbleView.backgroundColor = UIColor(red: 255.0/255.0, green: 204.0/255.0, blue: 0.0/255.0, alpha: 1.0) // Yellow
//        bubbleView.backgroundColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0) // Green
//        bubbleView.backgroundColor = UIColor(red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0) // Teal Blue
//        bubbleView.backgroundColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0) // Blue (Default)
//        bubbleView.backgroundColor = UIColor(red: 88.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0) // Purple
//        bubbleView.backgroundColor = UIColor(red: 255.0/255.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1.0) // Pink

        chatMessageLabel.textColor = UIColor.white

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
