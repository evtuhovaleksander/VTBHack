//
//  RequestSender.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case error(String)
}

protocol RequestSenderProtocol: class {
    
    typealias CompletionHandler<Model> = ((Result<Model>) -> Void)?
    
    func request<Model>(config: RequestConfig<Model>, completionHandler: CompletionHandler<Model>)
}

final class RequestSender: RequestSenderProtocol {
    
    var sessionManager: SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request<Model>(config: RequestConfig<Model>, completionHandler: CompletionHandler<Model>) {
        let utilityQueue = DispatchQueue.global(qos: .utility)
        sessionManager.request(
            config.url,
            method: config.method,
            parameters: config.parameters,
            encoding: config.encoding,
            headers: config.headers
        )
        .validate()
        .responseJSON(queue: utilityQueue) { response in
            switch response.result {
            case .success:
                guard let result = config.parser.parse(response) else {
                    completionHandler?(Result.error("Ошибка при получении данных"))
                    return
                }
                completionHandler?(Result.success(result))
            case .failure(let error):
                debugPrint(error)
                completionHandler?(Result.error("Нет связи с сервером"))
            }
        }
    }
}
