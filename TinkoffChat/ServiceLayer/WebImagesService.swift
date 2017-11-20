//
//  WebImagesService.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 21.11.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import Foundation

protocol IWebImagesService {
    func loadPictures(completion: @escaping () -> Void)
}

class WebImagesService: IWebImagesService {
    func loadPictures(completion: @escaping () -> Void) {
        
    }
}
