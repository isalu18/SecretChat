//
//  MessageBubble.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 10/05/22.
//

import SwiftUI

struct MessageBubble: View {
    
    @State private var displayTimeAndDecrypt = false
    var message: Message
    var body: some View {
        VStack(alignment: message.sender ? .trailing : .leading) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(message.sender ? .green : .cyan))
            }
            .frame(maxWidth: 300, alignment: message.sender ? .trailing : .leading)
            .onTapGesture {
                displayTimeAndDecrypt.toggle()
            }
            
            if displayTimeAndDecrypt {
                MessageDetails(message: message)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.sender ? .trailing : .leading)
        .padding(message.sender ? .trailing : .leading)
        .padding(.horizontal, 10)
    }
}

struct MessageDetails: View {
    var message: Message
    var body: some View {
        HStack(spacing: 20) {
            if message.sender {
                Button("Decrypt") {
                    
                }
                .padding(5)
                .font(.caption)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(alignment: .center)
                Text("\(message.timeStamp.formatted(.dateTime.hour().minute()))")
                    .frame(alignment: message.sender ? .trailing : .leading)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(message.sender ? .trailing : .leading, 10)
            } else {
                Text("\(message.timeStamp.formatted(.dateTime.hour().minute()))")
                    .frame(alignment: message.sender ? .trailing : .leading)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(message.sender ? .trailing : .leading, 10)
                Button("Decrypt") {
                    
                }
                .padding(5)
                .font(.caption)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .frame(alignment: .center)
            }
        }
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "12345", text: "Hello World from the other side dasdawdawdasdawdadwdadawdadwdwadawddawdadadawdaswd", sender: false, timeStamp: Date()))
    }
}
