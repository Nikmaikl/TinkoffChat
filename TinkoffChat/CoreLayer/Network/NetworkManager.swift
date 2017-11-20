//
//  NetworkManager.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 21.11.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import Foundation

protocol IRequest {
    var urlRequest: URLRequest? { get }
}
protocol IParser {
    associatedtype Model
    func parse(data: Data) -> Model?
}
struct RequestConfig<Parser> where Parser: IParser {
    let request: IRequest
    let parser: Parser
}
protocol IRequestSender {
    func send<Model>(config: RequestConfig<Model>,
        completionHandler: @escaping (Parser<Model>) -> Void)
}

