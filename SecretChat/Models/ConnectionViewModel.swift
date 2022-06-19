//
//  ConnectionViewModel.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 01/06/22.
//

import SwiftUI
import MultipeerConnectivity

class ConnectionViewModel: NSObject, ObservableObject {

//    enum AppState: String {
//        case inactive = "Inactive"
//        case searchingForChat = "Searching For Chat"
//        case connectedToHost = "Connected To Host"
//        case waitingForPeers = "Waiting for Peers"
//        case hostingWithPeers = "Hosting Chat"
//    }
    
//    @Published private(set) var appState = AppState.inactive
    
    enum AppState: String {
//        case connected = "Connected"
        case created = "Session created. Waiting for guests..."
        case connected = "Connection established successfully"
        case connecting =  "Connecting"
        case notConnected = "Not Connected"
        case disconnected = "Disconnected from session"
        case unknown = "Unknown"
    }
    
    @Published var appState = AppState.notConnected
    
    var peerID: MCPeerID
    var mcSession: MCSession
    var hostID: MCPeerID?
//    var mcAdvertiserAssitant: MCAdvertiserAssistant!
    var mcNearbyServiceAdvertiser: MCNearbyServiceAdvertiser?
    var browser: MCBrowserViewController
    
    override init() {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        browser = MCBrowserViewController(serviceType: "chatting", session: mcSession)
        super.init()
        mcSession.delegate = self
    }
    
    func advertise() {
        mcNearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "chatting")
        mcNearbyServiceAdvertiser?.delegate = self
        mcNearbyServiceAdvertiser?.startAdvertisingPeer()
//        appState = .waitingForPeers
    }
    
    func invite() {
//        browser = MCBrowserViewController(serviceType: "chatting", session: mcSession)
        browser.delegate = self
        DispatchQueue.main.async {
            let screen = UIApplication.shared.keyWindow
            screen?.rootViewController?.presentedViewController?.present(self.browser, animated: true, completion: nil)
        }
    }
    
    func disconnect() {
        mcNearbyServiceAdvertiser?.stopAdvertisingPeer()
        browser.browser?.stopBrowsingForPeers()
        mcSession.disconnect()
        
//        DispatchQueue.main.async {
//            self.appState = .inactive
//        }
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
            DispatchQueue.main.async {
                self.appState = .connected
            }
            print("\(peerID), state: \(appState)")
        case .connecting:
            DispatchQueue.main.async {
                self.appState = .connecting
            }
            print("\(peerID), state: \(appState)")
        case .notConnected:
            DispatchQueue.main.async {
                self.appState = .notConnected
            }
            print("\(peerID), state: \(appState)")
        default:
            DispatchQueue.main.async {
                self.appState = .unknown
            }
            print("\(peerID), state: \(appState)")
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
//        appState = .hostingWithPeers
    }
}

extension ConnectionViewModel: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
//        appState = .connectedToHost
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        disconnect()
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
