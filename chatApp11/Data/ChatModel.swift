//
//  ChatModel.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 29/09/20.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Chats : Codable,Identifiable, Hashable {
    @DocumentID var id : String?
    
    var userA : String
    var userB : String
    
    enum CodingKeys: String , CodingKey {
        case userA
        case userB
        case id
    }
     
}
