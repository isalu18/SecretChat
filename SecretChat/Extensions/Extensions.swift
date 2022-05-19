//
//  Extensions.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 18/05/22.
//
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
