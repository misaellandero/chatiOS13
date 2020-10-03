//
//  HomeView.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var session : SessionStore
    @EnvironmentObject var data : DataStore
    @State private var selection = 0
    
    
    private var NavigationBartitles = ["Home", "Contacts", "Profile"]
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
            TabView(selection: $selection){
               UserChatsView()
                .tabItem {
                        VStack {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    }
                    .tag(0)
                
                    ContactsView()
                     
                    .tabItem {
                        VStack {
                            Image(systemName: "person.2")
                            Text("Contacts")
                        }
                    }
                    .tag(1)
                
                    UserSettingsView(session: self.session)
                        
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                }
                .tag(2)
            }
         
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
