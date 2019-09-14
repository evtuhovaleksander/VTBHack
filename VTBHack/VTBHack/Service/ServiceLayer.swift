//
//  ServiceLayer.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation

class ServiceLayer {
    static let shared = ServiceLayer()
    
    let requestService: RequestSender
//    let authService: AuthService
//    let incoiveService: InvoiceService
    let checkService: CheckInfoService
    
    private init() {
        requestService = RequestSender()
        
//        authService = AuthService(requestSender: requestService)
//        incoiveService = InvoiceService(requestSender: requestService)
        checkService = CheckInfoService(requestSender: requestService)
    }
    
}
