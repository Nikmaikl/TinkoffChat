//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 06.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, CommunicationServiceDelegate{

    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var conversationTableView: UITableView!
    @IBOutlet weak var sendMsgTextField: UITextField!
    @IBOutlet weak var bottomBarHeightConstraint: NSLayoutConstraint!
    
    var messages = [Message]()
    
    var communicationManager: CommunicationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendBtn.tintColor = UIColor.lightGray

        setUpMessages()
        
        communicationManager = CommunicationService()
        
        communicationManager.conversationDelegate = self
        
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
        
        conversationTableView.rowHeight = UITableViewAutomaticDimension
        conversationTableView.estimatedRowHeight = 44
        
        sendMsgTextField.delegate = self
    }
    
    func shouldReload() {
        conversationTableView.reloadData()
    }
    
    func setUpMessages() { }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MessageTableViewCell
        var indentifier = ""
        
        if messages[indexPath.row].incoming {
            indentifier = "incomingMessage"
        } else {
            indentifier = "outgoingMessage"
        }
        
        if let messageCell = tableView.dequeueReusableCell(withIdentifier: indentifier) as? MessageTableViewCell {
            cell = messageCell
        } else {
            cell = MessageTableViewCell(style: .default, reuseIdentifier: indentifier)
        }
        
        cell.configure(message: messages[indexPath.row])
        
        return cell
    }
    
    @IBAction func sendMsgPressed(_ sender: Any) {
//        messages.append(Message(text: sendMsgTextField.text, incoming: false))
        self.sendMsgTextField.text = ""
        self.conversationTableView.reloadData()
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        if sendMsgTextField.text == "" { return }
        
        if self.sendBtn.tintColor != UIColor.blue {
            UIView.animate(withDuration: 0.5, animations: {
                self.sendBtn.setTitleColor(UIColor.blue, for: .normal)
            
            }, completion: {
                finished in
                UIView.animate(withDuration: 0.5, animations: {
                   self.sendBtn.layer.setAffineTransform(CGAffineTransform(scaleX: 0.15, y: 0.15))
                    
                }, completion: {
                    finished in
                    self.sendBtn.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0, y: 1.0))
                })
            })
        }

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomBarHeightConstraint.constant = 350
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bottomBarHeightConstraint.constant = 50
        textField.resignFirstResponder()
        return true
    }
}
