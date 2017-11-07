//
//  StorageManager.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 06.11.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//


import CoreData
import UIKit

class StorageManager {
    let stack: CoreDataStackDelegate
    
    init(stack: CoreDataStackDelegate) {
        self.stack = stack
    }
    
    func saveProfile(savingProfile: Profile) {
        if let appUser = AppUser.findOrInsertAppUser(in: stack.saveContext!) {
            if let user = appUser.currentUser {
                user.name = savingProfile.name
                user.userDescription = savingProfile.description
                user.photo = UIImagePNGRepresentation(savingProfile.photo!)
                
                stack.saveContext?.perform {
                    self.stack.performSave(context: self.stack.saveContext!, completionHandler: {
                        saved in
                    })
                }
            }
        }
    }
    
    func getProfile(completion: @escaping (_ profile: Profile) -> ()) {
        stack.saveContext?.perform {
            if let appUser = AppUser.findOrInsertAppUser(in: self.stack.saveContext!) {
                if let user = appUser.currentUser {
                    DispatchQueue.main.async {
                        let profile = Profile(name: user.name, description: user.userDescription, photo: nil)
                        
                        if let imageData = user.photo {
                            profile.photo = UIImage(data: imageData)
                        }
                        
                        completion(profile)
                    }
                }
            }
        }
    }
    
}
