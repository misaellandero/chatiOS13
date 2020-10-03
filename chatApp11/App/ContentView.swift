//
//  ContentView.swift
//  Shared
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session : SessionStore
    @EnvironmentObject var data : DataStore
    
    func getUser(){
        session.listen()
    }
    var body: some View {
        Group{
            if (session.session != nil) {
                HomeView() 
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
