//
//  GCDDataManager.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 16.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit

class GCDDataManager: DataManager {
    static func saveToFile(name: String, bio: String, photo: UIImage, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let fileManager = FileManager.default
            do {
                let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                let imgFileURL = documentDirectory.appendingPathComponent("SavedImage.txt")
                let nameFileURL = documentDirectory.appendingPathComponent("SavedName.txt")
                let bioFileURL = documentDirectory.appendingPathComponent("SavedBio.txt")
                if let imageData = UIImageJPEGRepresentation(photo, 1.0) {
                    try imageData.write(to: imgFileURL)
                }
                try name.write(to: nameFileURL, atomically: true, encoding: String.Encoding.utf8)
                try bio.write(to: bioFileURL, atomically: true, encoding: String.Encoding.utf8)
                
                completion()
            } catch {
                print(error)
            }
        }
    }
    
    static func readFromFile(completion: @escaping (String, String, UIImage) -> Void) {
        DispatchQueue.main.async {
            var newName: String? = nil
            var newBio: String? = nil
            var newPhoto: UIImage? = nil
            
            if let filepath = Bundle.main.path(forResource: "SavedName", ofType: "txt") {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    newName = contents
                }
                catch {
                    print(error)
                }
            }
            
            if let filepath = Bundle.main.path(forResource: "SavedBio", ofType: "txt") {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    newBio = contents
                }
                catch {
                    print(error)
                }
            }
            
            if let filepath = Bundle.main.path(forResource: "SavedImage", ofType: "txt") {
                do {
                    let contents = try String(contentsOfFile: filepath)
                    newPhoto = UIImage(data: Data(base64Encoded: contents)!)
                }
                catch {
                    print(error)
                }
            }
            
            if let name = newName, let bio = newBio, let photo = newPhoto {
                completion(name, bio, photo)
            }
        }
    }

}
