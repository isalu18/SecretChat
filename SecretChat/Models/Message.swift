//
//  Message.swift
//  SecretChat
//
//  Created by Isaac Sanchez on 10/05/22.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var sender: Bool
    var timeStamp: Date
}
