//
//  Parser.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 21.11.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import Foundation

class Parser<T> : IParser {
    typealias Model = T
    func parse(data: Data) -> T? { return nil }
}
