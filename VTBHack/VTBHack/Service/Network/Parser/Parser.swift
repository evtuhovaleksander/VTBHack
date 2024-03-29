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

class SessionParser: Parser<SessionDto> {
    override func parse(_ response: DataResponse<Any>) -> SessionDto? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(SessionDto.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}

class AccountBalanceParser: Parser<AccountBalanceDto> {
    override func parse(_ response: DataResponse<Any>) -> AccountBalanceDto? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(AccountBalanceDto.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}

class InvoiceParser: Parser<InvoiceDto> {
    override func parse(_ response: DataResponse<Any>) -> InvoiceDto? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(InvoiceDto.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}

class InvoiceInfoParser: Parser<InvoiceInfoDto> {
    override func parse(_ response: DataResponse<Any>) -> InvoiceInfoDto? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(InvoiceInfoDto.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}

class AccountAddressParser: Parser<AccountAddressDto> {
    override func parse(_ response: DataResponse<Any>) -> AccountAddressDto? {
        guard let data = response.data else { return nil }
        do {
            let model = try JSONDecoder().decode(AccountAddressDto.self, from: data)
            return model
        } catch {
            return nil
        }
    }
}
