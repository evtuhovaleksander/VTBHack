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
    let accountService: AccountService
//    let incoiveService: InvoiceService
    let checkService: CheckInfoService
    let infoService: InfoService
    
    private init() {
        requestService = RequestSender()
        
        accountService = AccountService(requestSender: requestService)
//        incoiveService = InvoiceService(requestSender: requestService)
        checkService = CheckInfoService(requestSender: requestService)
        infoService = InfoService()
    }
    
}
