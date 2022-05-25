//
//  ContentView.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 10/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAlert = true
    @State private var isSafeMode: Bool = false
    
    @State private var messages = ["Hello", "How are you?", "Nice to meet you", "Regards", "I'm building a SwiftUI App from scratch"]
    var body: some View {
        VStack {
            VStack {
                TitleView(isSafeMode: $isSafeMode)
                
                ScrollView {
                    ForEach(messages, id: \.self) { message in
                        MessageBubble(message: Message(id: "12345", text: message, sender: true, timeStamp: Date()))
                    }
                }
                .padding(.top, 10)
            }
            .onTapGesture {
                hideKeyboard()
            }
            MessageFieldView(messages: $messages)
        
        }
        .alert("Would you like to enable Safe Mode?", isPresented: $showAlert, actions: {
            
            Button("Yes") {
                isSafeMode = true
            }
            Button("No", role: .cancel) {
                isSafeMode = false
            }
        }, message: {
            Text("Safe Mode means the messages are going to be encrypted")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
