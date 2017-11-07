//
//  Message.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 08.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit
import CoreData

struct Message: Codable {
    var text: String?
    var incoming: Bool
    

    private static func generateMessageId() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
        return string!
    }
}
