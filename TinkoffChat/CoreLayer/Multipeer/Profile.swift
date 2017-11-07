//
//  Profile.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 06.11.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

class Profile {
    var name: String?
    var description: String?
    var photo: UIImage?
    
    init(name: String?, description: String?, photo: UIImage?) {
        self.name = name
        self.description = description
        self.photo = photo
    }
}
