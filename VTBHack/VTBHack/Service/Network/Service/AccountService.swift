//
//  AuthService.swift
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
class AccountService {
    
    var sessionId = "ac5fb794-22e6-4108-84a0-468c95edbc68"
    
    private let requestSender: RequestSender
    
    init(requestSender: RequestSender) {
        self.requestSender = requestSender
    }
    
    func obtainSession(completion: ((Result<SessionDto>) -> Void)?) {
        let request = SessionRequest()
        requestSender.request(config: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.sessionId = model.data
                case .error(let error):
                    print(error)
                }
                completion?(result)
            }
        }
    }
    
    func obtainAccountBalance(address: String, completion: ((Result<AccountBalanceDto>) -> Void)?) {
        let request = AccountBalanceRequest(address: address)
        print(request.url)
        requestSender.request(config: request) { (result) in
            DispatchQueue.main.async {
                completion?(result)
            }
        }
    }

    
}
