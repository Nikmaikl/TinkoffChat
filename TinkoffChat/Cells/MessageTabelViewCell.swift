//
//  MessageTabelViewCell.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 08.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

protocol MessageCellConfiguration: class {
    var messageText: String? {get set}
}

class MessageTableViewCell: UITableViewCell, MessageCellConfiguration {
    var messageText: String?

    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var messageLblRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageLblLeftConstraint: NSLayoutConstraint!
    
    func configure(message: Message) {
        messageLbl.text = message.text
        
        if message.incoming {
            self.messageLblLeftConstraint.constant = 8
            self.messageLblRightConstraint.constant = self.contentView.frame.width/4
            self.messageLbl.textAlignment = .left
        } else {
            self.messageLblRightConstraint.constant = 8
            self.messageLblLeftConstraint.constant = self.contentView.frame.width/4
            self.messageLbl.textAlignment = .right
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        messageText = nil
        
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        messageText = nil
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
