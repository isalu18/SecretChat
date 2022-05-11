//
//  ContentView.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 10/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TitleView()
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
