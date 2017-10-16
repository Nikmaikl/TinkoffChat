//
//  DataManager.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 16.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

protocol DataManager {
    static func saveToFile(name: String, bio:String, photo: UIImage, completion: @escaping () -> Void)
    static func readFromFile(completion: @escaping (String, String, UIImage) -> Void)
}
