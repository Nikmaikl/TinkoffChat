//
//  Conversation.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 08.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit
import CoreData

struct Conversation {
    var name: String?
    var id: String?
    var mesage: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessages: Bool
    var messages: [Message]
}
