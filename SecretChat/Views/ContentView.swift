//
//  ContentView.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 10/05/22.
//

import SwiftUI

struct ContentView: View {
    
    var messages = ["Hello", "How are you?", "Nice to meet you", "Regards", "I'm building a SwiftUI App from scratch"]
    var body: some View {
        VStack {
            VStack {
                TitleView()
                
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
            MessageField()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
