//
//  MessageFieldView.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 12/05/22.
//

import SwiftUI

struct MessageFieldView: View {
    @State private var message = ""
    @FocusState private var messageIsFocused: Bool
    @Binding var messages: [String]
    
    var body: some View {
        HStack {
            //            CustomMessageField(text: $message, placerholder: Text("What are you thinking?"))
            TextField("Type something", text: $message)
                .focused($messageIsFocused)
                .submitLabel(.send)
                .onSubmit {
                    sendMessage(messages: messages, message: message)
                }
            Button {
                sendMessage(messages: messages, message: message)
                messageIsFocused = false
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.cyan)
                    .cornerRadius(25)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
    
    func sendMessage(messages: [String], message: String) {
        withAnimation {
            self.messages.append(message)
            self.message = ""
        }
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageFieldView(messages: .constant(["Hola"]))
    }
}

