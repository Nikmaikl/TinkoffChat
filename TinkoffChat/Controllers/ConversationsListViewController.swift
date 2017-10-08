//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 06.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var conversationsTableView: UITableView!
    
    var onlineConversations = [Conversation]()
    var offlineConversations = [Conversation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        conversationsTableView.dataSource = self
        conversationsTableView.delegate = self
        
        setUpConversations()
    }
    
    func setUpConversations() {
        onlineConversations.append(Conversation(name: "Artem", mesage: "Hello, I'm here!", date: Calendar.current.date(byAdding: .hour, value: -1, to: Date())!, online: true, hasUnreadMessages: true))
        onlineConversations.append(Conversation(name: "Alexandr", mesage: nil, date: Calendar.current.date(byAdding: .hour, value: -6, to: Date())!, online: true, hasUnreadMessages: false))
        onlineConversations.append(Conversation(name: "Michael", mesage: "I'm here!", date: Date(), online: true, hasUnreadMessages: false))
        onlineConversations.append(Conversation(name: "Olga", mesage: "Hello", date: Calendar.current.date(byAdding: .hour, value: -9, to: Date())!, online: true, hasUnreadMessages: false))
        onlineConversations.append(Conversation(name: "Ruslan", mesage: "I'm here!", date: Date(), online: true, hasUnreadMessages: true))
        onlineConversations.append(Conversation(name: "Igor", mesage: "Hello, I'm here!", date: Calendar.current.date(byAdding: .hour, value: -10, to: Date())!, online: true, hasUnreadMessages: true))
        onlineConversations.append(Conversation(name: "Kirill", mesage: "I'm here!", date: Calendar.current.date(byAdding: .hour, value: -2, to: Date())!, online: true, hasUnreadMessages: false))
        onlineConversations.append(Conversation(name: "Ekaterina", mesage: "Hello!", date: Date(), online: true, hasUnreadMessages: false))
        onlineConversations.append(Conversation(name: "Sasha", mesage: "I'm here!", date: Date(), online: true, hasUnreadMessages: true))
        onlineConversations.append(Conversation(name: "Sasha", mesage: "Hello!", date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, online: true, hasUnreadMessages: true))
        
        offlineConversations.append(Conversation(name: "Masha", mesage: "Hello", date: Date(), online: false, hasUnreadMessages: true))
        offlineConversations.append(Conversation(name: "Kola", mesage: "I'm here!", date: Date(), online: false, hasUnreadMessages: true))
        offlineConversations.append(Conversation(name: "Artem", mesage: "Hello, I'm here!", date: Date(), online: false, hasUnreadMessages: false))
        offlineConversations.append(Conversation(name: "Pasha", mesage: "Hello", date: Date(), online: false, hasUnreadMessages: false))
        offlineConversations.append(Conversation(name: "Natan", mesage: "I'm here!", date: Date(), online: false, hasUnreadMessages: true))
        offlineConversations.append(Conversation(name: "Jimmmy", mesage: "Hello, I'm here!", date: Date(), online: false, hasUnreadMessages: true))
        offlineConversations.append(Conversation(name: "Lola", mesage: "Hello", date: Date(), online: false, hasUnreadMessages: false))
        offlineConversations.append(Conversation(name: "Ekaterina", mesage: "I'm here!", date: Date(), online: false, hasUnreadMessages: false))
        offlineConversations.append(Conversation(name: "Arkadiy", mesage: "Hello, I'm here!", date: Date(), online: false, hasUnreadMessages: true))
        offlineConversations.append(Conversation(name: "Mosha", mesage: "Hello!", date: Date(), online: false, hasUnreadMessages: true))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return onlineConversations.count
        case 1:
            return offlineConversations.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var conversations = [Conversation]()
        
        if indexPath.section == 0 { // Online users
            conversations = onlineConversations
        } else if indexPath.section == 1 { // History
            conversations = offlineConversations
        }
        
        let conversation = conversations[indexPath.row]
        
        let identifier = "ConversationCell"
        var cell: ConversationTableViewCell
        
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ConversationTableViewCell {
            cell = dequeuedCell
        } else {
            cell = ConversationTableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell.configure(conversation: conversation)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Online"
        case 1:
            return "History"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var titleForVC: String? = nil
        if indexPath.section == 0 {
            titleForVC = onlineConversations[indexPath.row].name
        } else if indexPath.section == 1 {
            titleForVC = offlineConversations[indexPath.row].name
        }
        
        performSegue(withIdentifier: "OpenConversation", sender: titleForVC)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ConversationViewController {
            if let title = sender as? String {
                destinationVC.title = title
            }
        }
    }
}
