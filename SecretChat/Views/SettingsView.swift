//
//  SettingsView.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 16/05/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
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
                        Button {
                            
                        } label: {
                            Text("Generate new key pairs")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(UIColor.systemGray2))
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Generate new public keys for friends")
                                .foregroundColor(.black)
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(UIColor.systemGray2))
                        }
                    }
                }
            }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
