//
//  SettingsView.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 16/05/22.
//

import SwiftUI

struct SettingsView: View {    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var connection: ConnectionViewModel
    @State private var isShowingSnackbar = false
    
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Settings")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.leading, 40)
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25, alignment: .trailing)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundColor(.black)
                
                ScrollView {
                    VStack {
                        Text("Keys Settings")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        
                        SettingsButton(title: "Generate new key pairs") {
                            
                        }
                        
                        SettingsButton(title: "Generate new public keys for friends") {
                            
                        }
                    }
                    
                    Divider()
                    
                    VStack {
                        Text("Session Settings")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        SettingsButton(title: "Create Session") {
                            connection.appState = .created
                            connection.advertise()
                            presentationMode.wrappedValue.dismiss()
                            withAnimation {
                                isShowingSnackbar.toggle()
                            }
                        }
                        
                        SettingsButton(title: connection.appState == .notConnected ? "Join Session" : "Disconnect") {
                            if connection.appState == .notConnected {
                                connection.invite()
                                if connection.appState == .connected {
                                    withAnimation {
                                        isShowingSnackbar.toggle()
                                    }
                                }
                            } else if connection.appState == .connected {
                                connection.appState = .disconnected
                                connection.disconnect()
                                presentationMode.wrappedValue.dismiss()
                                withAnimation {
                                    isShowingSnackbar.toggle()
                                }
                            }
                        }
                    }
                }
            }
        }
        Snackbar(isShowing: $isShowingSnackbar, message: connection.appState.rawValue)
    }
}

struct SettingsButton: View {
    var title: String
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: clicked) {
            Text(title)
                .foregroundColor(.black)
                .font(.title3)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(UIColor.systemGray2))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(connection: ConnectionViewModel())
    }
}
