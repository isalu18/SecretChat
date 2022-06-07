//
//  ConnectionViewModel.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 01/06/22.
//

import SwiftUI
import MultipeerConnectivity

class ConnectionViewModel: NSObject, ObservableObject {

    var peerID: MCPeerID
    var mcSession: MCSession
    var hostID: MCPeerID?
//    var mcAdvertiserAssitant: MCAdvertiserAssistant!
    var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser?
    
    override init() {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        super.init()
        mcSession.delegate = self
    }
    
    func advertise() {
        mcNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "chatting")
        mcNearbyServiceAdvertiser?.delegate = self
        mcNearbyServiceAdvertiser?.startAdvertisingPeer()
    }
    
    func invite() {
        let browser = MCBrowserViewController(serviceType: "chatting", session: mcSession)
        browser.delegate = self
        DispatchQueue.main.async {
            let screen = UIApplication.shared.keyWindow
            screen?.rootViewController?.presentedViewController?.present(browser, animated: true, completion: nil)
        }
    }
}

extension ConnectionViewModel: MCSessionDelegate {
    
//    func hostSession() {
////        mcAdvertiserAssitant = MCAdvertiserAssistant(serviceType: "chatting", discoveryInfo: nil, session: mcSession)
////        mcAdvertiserAssitant.start()
//    }
//
//    func joinSession() {
////        let mcBrowser = MCBrowserViewController(serviceType: "chatting", session: mcSession)
//    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("\(peerID), state: connected")
        case .connecting:
            print("\(peerID), state: connecting")
        case .notConnected:
            print("\(peerID), state: not connected")
        default:
            print("\(peerID), state: unknown")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}

extension ConnectionViewModel: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, mcSession)
    }
}

extension ConnectionViewModel: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
}

extension UIApplication {
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}
