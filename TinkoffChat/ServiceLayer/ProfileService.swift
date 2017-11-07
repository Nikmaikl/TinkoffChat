//
//  ProfileService.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 07.11.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

protocol ProfileServiceDelegate {
    func saveProfile(name: String?, description: String?, photo: UIImage?)
}

class ProfileService: ProfileServiceDelegate {
    let stack = CoreDataStack()
    
    func saveProfile(name: String?, description: String?, photo: UIImage?) {
        let data = StorageManager(stack: stack)
        data.saveProfile(savingProfile: Profile(name: name, description: description, photo: photo))
    }
    
    func getProfile(completion: @escaping (Profile) -> ()) {
        let data = StorageManager(stack: stack)
        data.getProfile(completion: completion)
    }
    
}
