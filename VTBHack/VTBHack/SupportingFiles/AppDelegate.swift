//
//  AppDelegate.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
//        let rawQRCode = "t=20190913T130200&s=190.00&fn=9287440300122136&i=61528&fp=1207037887&n=1"
//        ServiceLayer.shared.checkService.obtainCheckInfo(rawQRCode: rawQRCode) { result in
//            switch result {
//            case .error(let error):
//                print(error)
//            case .success(let model):
//                dump(model)
//            }
//        }
        
        ServiceLayer.shared.accountService.obtainSession { result in
            switch result {
            case .error(let error):
                print(error)
            case .success(let model):
                dump(model)
            }
        }
        
        return true
    }

}

