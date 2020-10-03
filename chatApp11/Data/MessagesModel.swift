//
//  MessagesModel.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Messages : Codable,Identifiable, Hashable {
    @DocumentID var id : String?
    
    var messages : String
    var uidOwner : String
    var emailAdress : String
    var date : Date
    
    enum CodingKeys: String , CodingKey {
        case messages
        case uidOwner
        case emailAdress
        case date
    }
      
}
