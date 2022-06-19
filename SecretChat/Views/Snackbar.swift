//
//  Snackbar.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 18/06/22.
//

import SwiftUI

struct Snackbar: View {
    @Binding var isShowing: Bool
    var message: String
    
    var body: some View {
        if isShowing {
            HStack {
                Image(systemName: "bell")
                Text(message)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.cyan)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(.horizontal, 25)
        }
    }
}

struct Snackbar_Previews: PreviewProvider {
    static var previews: some View {
        Snackbar(isShowing: .constant(true), message: "Connected")
    }
}
