//
//  CommunicationService.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 22.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

protocol CommunicationServiceDelegate: class {
    func shouldReload()
}


class CommunicationService: CommunicatorDelegate {
    
    var onlineConversations: [Conversation] = []
    
    var historyConversations: [Conversation] = []
    
    private var communicator: Communicator = MultipeerCommunicator()
    
    var online: Bool = false {
        didSet {
            if online {
                communicator.online = true
            } else {
                communicator.online = false
            }
        }
    }
    weak var conversationDelegate: CommunicationServiceDelegate?

    
    let conversationsHeadersTitle = ["Online", "History"]
    
    
    weak var conversationsDelegate: CommunicationServiceDelegate?
    
    init() {
        communicator.delegate = self
    }
    
    func didLostUser(userID: String) {
        var index: Int?
        for (i,conv) in onlineConversations.enumerated() {
            if conv.id == userID {
                index = i
                break
            }
        }
        if let index = index {
            onlineConversations[index].online = false
            onlineConversations.remove(at: index)
            DispatchQueue.main.async {
                self.conversationsDelegate?.shouldReload()
                self.conversationDelegate?.shouldReload()
            }
        }
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
    }
    
    func didFoundUser(userID: String, userName: String?) {
        for conv in onlineConversations {
            if conv.id == userID {
                return
            }
        }
        let newConversation = Conversation(name: userID, id: userName ?? "Unknown", mesage: nil, date: Date(), online: true, hasUnreadMessages: false, messages: [])
        
        onlineConversations.append(newConversation)
        
        self.conversationsDelegate?.shouldReload()
    }
    
    func failedToStartAdvertising(error: Error) {
    }
    
    func sendMessage(in conversation: Conversation, text: String, completion: ((Bool,Error?) -> ())?) {
        communicator.sendMessage(string: text, to: conversation.id!, completionHandler: { (success, error) in
            DispatchQueue.main.async {
                completion?(success, error)
                if success {
                    self.conversationDelegate?.shouldReload()
                }
            }
        })
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        let newMessage = Message(text: text, incoming: true)
        var inConversation: Conversation? = nil
        for conv in onlineConversations {
            if conv.id == fromUser {
                inConversation = conv
                break
            }
        }
        inConversation?.messages.append(newMessage)
        inConversation?.hasUnreadMessages = true
        DispatchQueue.main.async {
            self.conversationDelegate?.shouldReload()
            self.conversationsDelegate?.shouldReload()
        }
    }
}

