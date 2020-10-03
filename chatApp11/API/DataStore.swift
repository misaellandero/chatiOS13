//
//  dataStore.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI
import Firebase


class DataStore : ObservableObject {
     
    @Published var menssages : [Messages] = []
    @Published var contacts : [Contacts] = []
    @Published var users : [Users] = []
    @Published var chats : [Chats] = []
   
    init() {
        getUserContacts()
        getAllUsers()
        getUserMessages()
        getAllChats()
    }
    // MARK: - database
    let dataBase = Firestore.firestore()
    
    // MARK: - get userContacts
    func getUserContacts(){
        dataBase.collection("user_contacts").addSnapshotListener{ (snap, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach{ (doc) in
                if doc.type == .added {
                    let contact = try! doc.document.data(as: Contacts.self)!
                    DispatchQueue.main.async {
                            self.contacts.append(contact)
                    }
                }
            }
        }
    }
    
    func addContact(firstName: String, lastName: String, email: String, contactNumber: String, uidOwner: String){
        
        let contact = Contacts(firstName: firstName, lastName: lastName, email: email, contactNumber: contactNumber, uidOwner: uidOwner)
        
        let _ = try! dataBase.collection("user_contacts").addDocument(from: contact){ (error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    // MARK: - get all userMessages
    func getUserMessages(){
        dataBase.collection("Messages").addSnapshotListener{ (snap, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach{ (doc) in
                if doc.type == .added {
                    let message = try! doc.document.data(as: Messages.self)!
                    DispatchQueue.main.async {
                            self.menssages.append(message)
                    }
                }
            }
        }
    }
    
    func sendMessage(messages: String, uidOwner: String, emailAdress: String){
      
        let message = Messages(messages: messages, uidOwner: uidOwner, emailAdress: emailAdress, date: Date())
        
        let _ = try! dataBase.collection("Messages").addDocument(from: message){ (error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    // MARK: - get all App Users
    
    func getAllUsers(){
        dataBase.collection("users").addSnapshotListener{ (snap, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach{ (doc) in
                if doc.type == .added {
                    let user = try! doc.document.data(as: Users.self)!
                    DispatchQueue.main.async {
                            self.users.append(user)
                    }
                }
            }
        }
    }
    
    func addUser(email: String) -> Bool {
        
        let newUser = Users(email: email)
        var matchs = 0
        
        for user in users {
            if user.email == newUser.email {
                matchs += 1
            }
        }
         
        if  matchs > 1 {
            
            return false
            
        } else {
            
            let _ = try! dataBase.collection("users").addDocument(from: newUser){ (error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
            }
             
            return true
        }
         
        
    }
    
    // MARK: - get all Chats
    
    func getAllChats(){
        dataBase.collection("Chats").addSnapshotListener{ (snap, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach{ (doc) in
                if doc.type == .added {
                    let chat = try! doc.document.data(as: Chats.self)!
                    DispatchQueue.main.async {
                            self.chats.append(chat)
                    }
                }
            }
        }
    }
    
    func addChat(userA: String, userB: String){
        let chat =  Chats(userA: userA, userB: userB)
     
        let _ = try! dataBase.collection("Chats").addDocument(from: chat){ (error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    func reloadData(){
    }
}
