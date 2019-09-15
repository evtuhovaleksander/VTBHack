//
//  PeopleDataSource.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class Contact {
    var phone: String = ""
    var nickName: String = ""
    var selected = false
    
    var items = [Item]()
    var invoiceInfo: InvoiceInfoDto?
    
    init(phone: String, nickname: String, selected: Bool) {
        self.phone = phone
        self.nickName = nickname
        self.selected = selected
    }
}

class PeopleDataSource: NSObject {
    var people = [Contact]()
    var tableview: UITableView?
    var allowReload = false
}

class ContactBookPeopleDataSource: PeopleDataSource {
    override init() {
        super.init()
        people = [
            Contact(phone: "79999999999", nickname: "Никита", selected: false),
            Contact(phone: "78888888888", nickname: "Настя", selected: false)
        ]
    }
}

class MultiPeerPeopleDataSource: PeopleDataSource {
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    var browser: MCNearbyServiceBrowser!
    
    override init() {
        super.init()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        browser = MCNearbyServiceBrowser(peer: peerID, serviceType: "appcoda-mpc")
        browser.delegate = self
        browser.startBrowsingForPeers()
    }
}


extension MultiPeerPeopleDataSource: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
            let components = peerID.displayName.components(separatedBy: "#")
        guard components[0] != ServiceLayer.shared.infoService.identifier ?? "" else { return }
            people.append(Contact(phone: components[0], nickname: components[1], selected: false))
            if allowReload {
                tableview?.reloadData()
            }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        let components = peerID.displayName.components(separatedBy: "#")
        people.removeAll(where: { $0.phone == components[0] })
        if allowReload {
            tableview?.reloadData()
        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print(error.localizedDescription)
    }
}
