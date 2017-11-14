//
//  ConversationDataManager.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 14.11.2017.
//  Copyright © 2017 com.minikolev.TinkoffChat. All rights reserved.
//

import UIKit
import CoreData

class ConversationDataManager: NSObject, NSFetchedResultsControllerDelegate {
    let mainTableView: UITableView
    var user = NSFetchedResultsController<User>()
    var messages = NSFetchedResultsController<Message>()

    init(mainTableView: UITableView) {
        self.mainTableView = mainTableView
        super.init()
    }
    
    func fetchUser() {
        user.delegate = self
        do {
            try user.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchMessages() {
        messages.delegate = self
        do {
            try messages.performFetch()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.mainTableView.endUpdates()
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.mainTableView.beginUpdates()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async {
            switch type {
            case .delete:
                
                if controller == self.messages {
                    let indexPaths = [IndexPath(row: 0, section: 0),]
                    self.mainTableView.deleteRows(at: indexPaths, with: .automatic)
                }
                else {
                    if let indexPath = indexPath {
                        self.mainTableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
                
            case .insert:
                if controller == self.messages {
                    let indexPaths = [IndexPath(row: 0, section: 0),]
                    self.mainTableView.insertRows(at: indexPaths, with: .automatic)
                }
                else {
                    if let newIndexPath = newIndexPath {
                        self.mainTableView.insertRows(at: [newIndexPath], with: .automatic)
                    }
                }
            case .move:
                if let indexPath = indexPath {
                    self.mainTableView.deleteRows(at: [indexPath], with: .automatic)
                }
                if let newIndexPath = newIndexPath {
                    self.mainTableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            case .update:
                if let indexPath = indexPath {
                    self.mainTableView.reloadRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
}

