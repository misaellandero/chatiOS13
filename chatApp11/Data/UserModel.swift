//
//  UserModel.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Users : Codable, Identifiable, Hashable {
    
    @DocumentID var id : String?
    
    var email: String
    
    enum CodingKeys: String , CodingKey {
        case id
        case email
    }
    
}
