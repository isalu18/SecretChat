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
            MessageField()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TitleView: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text("Unknown User")
                    .font(.title)
                .fontWeight(.bold)
                Text("online")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding()
        .background(.cyan)
    }
}
