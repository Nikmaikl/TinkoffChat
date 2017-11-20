//
//  WebImagesRequest.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 21.11.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import Foundation

class WebImagesRequest: IRequest {
    var urlRequest: URLRequest? {
        let urlString: String = "https:pixabay.com/api/?key=7116882-2b48200aec3a42d9e6e00cac6&q=yellow+flowers&image_type= photo&pretty=true&per_page=10"
        if let url = URL(string: urlString) {
            return URLRequest(url: url)
        }
        
        return nil
    }

}


