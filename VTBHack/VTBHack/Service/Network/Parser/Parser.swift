//
//  Parser.swift
//  VTBHack
//
//  Created by Кирилл Володин on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import Alamofire

class Parser<Model> {
    func parse(_ response: DataResponse<Any>) -> Model? {
        return nil
    }
}

//class AuthParser: Parser<Account> {
//    override func parse(_ response: DataResponse<Any>) -> Account? {
//        guard let data = response.data else { return nil }
//        do {
//            let model = try JSONDecoder().decode(Cost.self, from: data)
//            return model
//        } catch {
//            return nil
//        }
//    }
//}

class CheckInfoParser: Parser<CheckInfoDto> {
    override func parse(_ response: DataResponse<Any>) -> CheckInfoDto? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(CheckInfoDto.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
