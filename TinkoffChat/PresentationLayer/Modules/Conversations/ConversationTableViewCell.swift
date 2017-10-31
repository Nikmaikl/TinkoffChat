//
//  ConversationTableViewCell.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 06.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

protocol ConversationCellConfiguration: class {
    var nameLbl: UILabel! {get set}
    var messageLbl: UILabel! {get set}
    var dateLbl: UILabel! {get set}
    
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessages: Bool {get set}
}

class ConversationTableViewCell: UITableViewCell, ConversationCellConfiguration {
    
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessages: Bool

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    func configure(conversation: Conversation) {
        name = conversation.name
        message = conversation.mesage
        date = conversation.date
        online = conversation.online
        hasUnreadMessages = conversation.hasUnreadMessages
        
        nameLbl.text = name
        messageLbl.text = message
        
        if let conversationMessage = message {
            if hasUnreadMessages {
                messageLbl.font = .boldSystemFont(ofSize: 16.0)
            } else {
                messageLbl.font = UIFont.systemFont(ofSize: 16)
            }
            messageLbl.text = conversationMessage
        } else {
            messageLbl.font = UIFont.italicSystemFont(ofSize: 16)
            messageLbl.text = "No messages yet"
        }
        
        if let conversationDate = date {
            let dayTimePeriodFormatter = DateFormatter()
            let passedDay = Calendar.current.component(.day, from: conversationDate)
            let todayDay = Calendar.current.component(.day, from: Date())
            
            if passedDay < todayDay {
                dayTimePeriodFormatter.dateFormat = "dd MMM"
            } else {
                dayTimePeriodFormatter.dateFormat = "HH:mm"
            }
            
            let dateString = dayTimePeriodFormatter.string(from: conversationDate)
            
            dateLbl.text = dateString
        } else {
            dateLbl.text = ""
        }
        
        if online {
            self.backgroundColor = UIColor(red: 255/255, green: 254/255, blue: 209/255, alpha: 1.0)
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = nil
        message = nil
        date = nil
        online = false
        hasUnreadMessages = false
        
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        name = nil
        message = nil
        date = nil
        online = false
        hasUnreadMessages = false
        
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
