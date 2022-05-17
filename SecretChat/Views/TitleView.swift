//
//  TitleView.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 16/05/22.
//

import SwiftUI

struct TitleView: View {
    @State var showSettingsScreen = false
    
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
            
            Button {
                withAnimation{ showSettingsScreen.toggle() }
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.black)
                
            }
            .sheet(isPresented: $showSettingsScreen) {
                SettingsView()
            }
        }
        .padding()
        .background(.cyan)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
