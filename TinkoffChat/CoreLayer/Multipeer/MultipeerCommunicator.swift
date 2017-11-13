//
//  MultipeerCommunicator.swift
//  TinkoffChat
//
//  Created by Michael Nikolaev on 22.10.2017.
//  Copyright © 2017 Michael Nikolaev. All rights reserved.
//

import UIKit
import MultipeerConnectivity

protocol CommunicatorDelegate: class {

    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)
    
    func failedToStartBrowsingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
}

protocol Communicator {
    func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?)
    weak var delegate: CommunicatorDelegate? { get set }
    var online: Bool { get set }
}

class MultipeerCommunicator: NSObject, Communicator {
    
    weak var delegate: CommunicatorDelegate?
    
    var online: Bool = false {
        didSet {
            if online {
                browser.startBrowsingForPeers()
                advertiser.startAdvertisingPeer()
            } else {
                browser.startBrowsingForPeers()
                advertiser.stopAdvertisingPeer()
            }
        }
    }
    
    var ownPeerID: MCPeerID!
    var sessions: [MCPeerID: MCSession] = [:]
    var usernames: [MCPeerID: String] = [:]
    
    var browser: MCNearbyServiceBrowser!
    var advertiser: MCNearbyServiceAdvertiser!
    
    override init() {
        super.init()
        
        guard let vendorID = UIDevice.current.identifierForVendor else { return }
        let username = "Test"
        let serviceType = "tinkoff-chat"
        
        ownPeerID = MCPeerID(displayName: vendorID.description)
        browser = MCNearbyServiceBrowser(peer: ownPeerID, serviceType: serviceType)
        advertiser = MCNearbyServiceAdvertiser(peer: ownPeerID, discoveryInfo: ["userName": username], serviceType: serviceType)
        
        browser.delegate = self
        advertiser.delegate = self
    }
    
    // Communicator protocol
    func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?) {}

    private var getInviteData: Data {
        let username = "Test"
        let discoveryInfo = ["userName": username]
        var data: Data = Data()
        do {
            data = try JSONEncoder().encode(discoveryInfo)
        } catch {
        }
        return data
    }
    
    
    func getUsername(from data: Data?) -> String? {
        
        guard let fromData = data else { return nil }
        do {
            let username = try JSONDecoder().decode([String:String].self, from: fromData)["userName"]
            if username != nil {
                return username
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
}

extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            delegate?.didFoundUser(userID: peerID.displayName, userName: usernames[peerID])
        case .notConnected:
            delegate?.didLostUser(userID: peerID.displayName)
        default:
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        do {
//            var message = try JSONDecoder().decode(Message.self, from: data)
//            message.incoming = true
//            delegate?.didReceiveMessage(text: message.text!, fromUser: peerID.displayName, toUser: ownPeerID.displayName)
//        } catch {
//            return
//        }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        delegate?.failedToStartBrowsingForUsers(error: error)
        online = false
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        if let username = info?["userName"] {
            usernames[peerID] = username
        }
        
        let session = MCSession(peer: ownPeerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        sessions[peerID] = session
        
        browser.invitePeer(peerID, to: session, withContext: getInviteData, timeout: 0)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.didLostUser(userID: peerID.displayName)
        sessions.removeValue(forKey: peerID)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        delegate?.failedToStartAdvertising(error: error)
        online = false
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {

        let session = MCSession(peer: ownPeerID, securityIdentity: nil, encryptionPreference: .none)
        session.delegate = self
        sessions[peerID] = session
        invitationHandler(true, session)
        if let username = getUsername(from: context) {
            usernames[peerID] = username
        }
    }
}
