//
//  ContactsModel.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Contacts : Codable, Identifiable, Hashable {
    
    @DocumentID var id : String?
    
    var firstName: String
    var lastName: String
    var email: String
    var contactNumber : String
    var uidOwner : String
    
    enum CodingKeys: String , CodingKey {
        case firstName
        case lastName
        case email
        case contactNumber
        case uidOwner
    }
    
    func isDuplicated(users: [Contacts], email: String) -> Bool{
      
        let results = users.filter { $0.email == self.email }
        let exists = results.isEmpty == false
        return exists
    }
    
    func haveChat(appUsers: [Users]) -> Bool{
        print(appUsers)
        let results = appUsers.filter { $0.email == self.email }
        let exists = results.isEmpty == false
        return exists
    }
    
    
}



 
