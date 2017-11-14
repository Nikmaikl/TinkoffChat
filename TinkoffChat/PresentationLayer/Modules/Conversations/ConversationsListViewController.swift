//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 06.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConversationsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CommunicationServiceDelegate {

    @IBOutlet weak var conversationsTableView: UITableView!
    
    var onlineConversations = [Conversation]()
    var offlineConversations = [Conversation]()
    
    var communicationManager = CommunicationService()
    let dataManager = GCDDataManager()
    
    var conversationManager: ConversationDataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        conversationsTableView.dataSource = self
        conversationsTableView.delegate = self
        
        communicationManager.online = true
        communicationManager.conversationsDelegate = self
        
        setUpConversations()
        
    }
    
    func setUpConversations() { }
    
    func shouldReload() {
        DispatchQueue.main.async {
            self.conversationsTableView.reloadData()
        }
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
            return communicationManager.onlineConversations.count
        case 1:
            return communicationManager.historyConversations.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var conversations = [Conversation]()
        
        if indexPath.section == 0 { // Online users
            conversations = communicationManager.onlineConversations
        } else if indexPath.section == 1 { // History
            conversations = communicationManager.historyConversations
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
            titleForVC = communicationManager.onlineConversations[indexPath.row].name
        } else if indexPath.section == 1 {
            titleForVC = communicationManager.historyConversations[indexPath.row].name
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
