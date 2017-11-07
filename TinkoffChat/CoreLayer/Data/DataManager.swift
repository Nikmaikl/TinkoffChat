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

extension DataManager {
    var documentDirectory: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func save(data: Data, to file: String) -> Bool {
        if let oldData = read(from: file),
            oldData == data {
            return true
        }
        
        if let dir = documentDirectory {
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                try data.write(to: fileURL)
                return true
            }
            catch {
                return false
            }
        } else {
            return false
        }
    }
    
    func read(from file: String) -> Data? {
        guard let dir = documentDirectory else {
            return nil
        }
        
        let fileURL = dir.appendingPathComponent(file)
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        }
        catch {
            return nil
        }
    }
}
