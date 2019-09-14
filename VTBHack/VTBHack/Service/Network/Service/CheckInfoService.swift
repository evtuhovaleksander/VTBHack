//
//  CheckInfoService.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

//protocol AuthServiceProtocol {
//
//    typealias AuthUserCompletion = ((Result<AuthResult>) -> Void)?
//    func authUser(login: String, password: String, completion: AuthUserCompletion)
//}
//
class CheckInfoService {

    private let requestSender: RequestSender

    init(requestSender: RequestSender) {
        self.requestSender = requestSender
    }

    func obtainCheckInfo(rawQRCode: String, completion: ((Result<CheckInfoDto>) -> Void)?) {
        let request = CheckInfoRequest(rawQRCode: rawQRCode)
        requestSender.request(config: request) { (result) in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }

}
