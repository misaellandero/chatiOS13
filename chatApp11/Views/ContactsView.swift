//
//  ContactsView.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI

struct ContactsView: View {
    
    @EnvironmentObject var session : SessionStore
    @EnvironmentObject var data : DataStore
    
    @State var showAddContact = false
    
    var contacts : [Contacts] {
        var contacts = [Contacts]()
        
        for contact in data.contacts {
            if contact.uidOwner == session.user?.uid ?? "No user" {
                contacts.append(contact)
            }
        }
         
         return contacts
    }
    
    
    var body: some View {
        NavigationView{
                    List{
                        ForEach(contacts, id: \.self){ contac in
                            
                            if contac.uidOwner == session.user?.uid {
                                NavigationLink(
                                    destination: ContactDetailView(contac: contac)){
                                    ContactView(contac: contac)
                                }
                            } 
                        }
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Contacts")
                    
            .navigationBarItems(trailing:
                                    HStack{
                                        Button(action: {
                                        showAddContact.toggle()
                                        }){
                                            Image(systemName: "person.crop.circle.fill.badge.plus")
                                        }
                                    }
                                    )
        }
        .sheet(isPresented:$showAddContact){
            NewContactView()
        }
    }
}

struct NewContactView : View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var contactNumber = ""
    @State var uidOwner = ""
    
    @EnvironmentObject var session : SessionStore
    @EnvironmentObject var data : DataStore
    @Environment(\.presentationMode) var presentationMode
    
    
    
    var body: some View{
        NavigationView{
            ScrollView {
                VStack(spacing: 20){
                    
                    circleColorIconSystem(name: "person.crop.circle.fill.badge.plus")
                        .padding()
                        .frame(width: 250)
                    
                    HStack{
                        Image(systemName: "person.2")
                        TextField("firstName", text: $firstName)
                        TextField("lastName", text: $lastName)
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    
                    HStack{
                        Image(systemName: "envelope.circle.fill")
                         TextField("email", text: $email)
                         .autocapitalization(.none)
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    
                    HStack{
                        Image(systemName: "phone.fill")
                        TextField("contactNumber", text: $contactNumber)
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    
                    Button(action: {
                        data.addContact(firstName: firstName, lastName: lastName, email: email, contactNumber: contactNumber, uidOwner: session.user?.uid ?? "No user")
                        presentationMode.wrappedValue.dismiss()
                        
                    }){
                       PrymaryButton(text: "Save", icon: "plus.circle")
                    }
                    
                    Button(action: {
                        
                            presentationMode.wrappedValue.dismiss()
                        
                    }){
                        CancelButton(text: "Cancel", icon: "xmark.circle.fill")
                    }
                    
                }
                .frame(minWidth:0, maxWidth: 300)
                .padding()
                Spacer()
            }
            .navigationBarTitle("New Contact", displayMode: .inline)
            
        }
    }
}

struct ContactDetailView : View {
    
    @State var contac: Contacts
    @EnvironmentObject var data : DataStore
    @EnvironmentObject var session : SessionStore
    
    var letterIcon : String {
        let str = Array(contac.firstName)[0]
        return str.lowercased()
    }
    
    @State private var showChatView = false
    @State private var showingAlert = false
    
    var body: some View{
        List{
            HStack(alignment: .center){
                Spacer()
                Button(action:{callPhone()}){
                    Image(systemName: "phone.fill")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(20)
                
                Spacer()
                circleColorIconSystem(name: "\(letterIcon).circle.fill")
                    .padding()
                    .frame(width: 150)
                Spacer()
                
                Button(action:{
                    self.sendMessage()
                }){
                    Image(systemName: "message.fill")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                Spacer()
            }
            .buttonStyle(BorderlessButtonStyle())
            
            Section(header: Text("Name")) {
                HStack{
                    Text(contac.firstName)
                    Text(contac.lastName)
                }
                .font(.largeTitle)
            }
            
            Section(header: Text("Contact Info")) {
                HStack{
                    Text(contac.email)
                }
                HStack{
                    Text(contac.contactNumber)
                }
                
            }
            
           
        }
        .listStyle(InsetGroupedListStyle())
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Important"), message: Text("User dont have account on AppChat! call him to invite"), dismissButton: .default(Text("Got it!")))
        }
        .sheet(isPresented: $showChatView) {
              
            ChatsView(messages: data.menssages, contact: self.contac, sender: self.session.user?.email ?? "No email", reciber: self.contac.email)
        }
        .navigationBarTitle(contac.firstName, displayMode: .inline)
        .navigationBarItems(trailing:
            HStack{
                Button(action:{callPhone()}){
                    Image(systemName: "phone.fill")
                }
                .accentColor(.green)
               
                Button(action:{
                    self.sendMessage()
                    
                }){
                    Image(systemName: "message.fill")
                }
                .accentColor(.blue)
        })
    }
    
    func sendMessage(){
        if contac.haveChat(appUsers: data.users) {
            let userA = session.user?.email ?? "No user"
            let userB = contac.email
            if !isDuplicated(chats: data.chats, userA: userA, userB: userB){
                data.addChat(userA: userA, userB: userB)
            }
            self.showChatView.toggle()
        } else {
            self.showingAlert.toggle()
        }
    }
    
    func callPhone(){
            let tel = "tel://"
            let formattedString = tel + contac.contactNumber
            let url: NSURL = URL(string: formattedString)! as NSURL
            UIApplication.shared.open(url as URL)
        
    }
}

func isDuplicated(chats: [Chats], userA: String, userB: String) -> Bool{
  
    let resultsA = chats.filter { $0.userA == userA && $0.userB == userB }
    let resultsB = chats.filter { $0.userA == userB && $0.userB == userA }
    
    let exists = (resultsA.isEmpty == false) || (resultsB.isEmpty == false)

    return exists
}

struct ContactView : View {
    @State var contac: Contacts
    var body: some View{
        HStack{
            Text(contac.firstName)
            Text(contac.lastName)
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
