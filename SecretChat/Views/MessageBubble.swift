//
//  MessageBubble.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 10/05/22.
//

import SwiftUI

struct MessageBubble: View {
    
    @State private var displayTime = false
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
                displayTime.toggle()
            }
            
            if displayTime {
                Text("\(message.timeStamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(message.sender ? .trailing : .leading, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.sender ? .trailing : .leading)
        .padding(message.sender ? .trailing : .leading)
        .padding(.horizontal, 10)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(id: "12345", text: "Hello World from the other side dasdawdawdasdawdadwdadawdadwdwadawddawdadadawdaswd", sender: true, timeStamp: Date()))
    }
}
