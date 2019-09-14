//
//  MultiPeerService.swift
//  VTBHack
//
//  Created by Aleksander Evtuhov on 14/09/2019.
//  Copyright © 2019 RxProject. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class MultiPeerService {
    var peerID: MCPeerID
    var mcSession: MCSession
    var advertiser: MCNearbyServiceAdvertiser
    init() {
        let phone = ServiceLayer.shared.infoService.identifier
        let nick = ServiceLayer.shared.infoService.nick
        peerID = MCPeerID(displayName: "\(phone ?? "*******")#\(nick)")
        mcSession = MCSession(peer: peerID)
        advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "appcoda-mpc")
        advertiser.startAdvertisingPeer()
    }
}
