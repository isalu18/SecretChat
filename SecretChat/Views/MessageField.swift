//
//  MessageField.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 12/05/22.
//

import SwiftUI

struct MessageField: View {
    
    @State private var message = ""
    @FocusState private var messageIsFocused: Bool
    
    var body: some View {
        HStack {
            CustomMessageField(text: $message, placerholder: Text("What are you thinking?"))
                .focused($messageIsFocused)
                .submitLabel(.send)
            Button {
                print(message)
                message = ""
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
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
    }
}

struct CustomMessageField: View {
    @Binding var text: String
    var placerholder: Text
    var editingChanged: (Bool) -> () = { _ in }
//    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placerholder
                    .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged) {
                print(text)
                text = ""
            }
        }
    }
}
