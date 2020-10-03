//
//  HomeView.swift
//  ChatApp
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI

struct UserSettingsView: View {
    @ObservedObject var session : SessionStore
    @EnvironmentObject var data : DataStore
    var body: some View {
        NavigationView{
            List {
                Section (header: HStack{Image(systemName: "person.crop.circle.fill")
                    Text("User Data")}){
                    HStack{
                        Image(systemName: "envelope.circle.fill")
                        Text(String(session.session?.email ?? "No especificado"))
                    }
                    NavigationLink(destination: resetPasswordView()) {
                       HStack{
                        Image(systemName: "arrow.clockwise.circle.fill")
                        Text("Recover PassWord")
                       }
                    }
                     
                    HStack{
                        Image(systemName: "xmark.circle.fill")
                        Button(action: {
                            session.signOut()
                            data.reloadData()
                            
                        }){
                            Text("Exit")
                        }
                    }
                    .foregroundColor(.red)
                }
                
                Section (header: HStack{Image(systemName: "info.circle.fill")
                    Text("About ")}){
                        HStack{
                            Text("Build")
                            Spacer()
                            Text("Alfa 0.1")
                                .foregroundColor(.secondary)
                        }
                        NavigationLink(destination: Text("Misael Landero Test App")) {
                            HStack{
                                Text("About me")
                            }
                        }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("User Settings")
        }
    
    }
}

struct UserSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserSettingsView(session: SessionStore())
    }
}
