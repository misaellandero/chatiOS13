//
//  ChatAppApp.swift
//  Shared
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//


import SwiftUI

struct SingInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    //@State var keyboardValue : CGFloat = 0
    
    @EnvironmentObject var session: SessionStore
    
    func signIn(){
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
   var body: some View {
   
        GeometryReader { geometry in
            ScrollView{
                VStack{
                     circleColorIcon()
                        .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                        
                    Text("ChatApp")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    Text("LogIn")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    VStack (spacing: 18){
                        HStack{
                            Image(systemName: "envelope.circle.fill")
                            TextField("Email", text: self.$email)
                                .autocapitalization(.none)
                            
                        }
                        .padding(12)
                        .frame(minWidth:0, maxWidth: 400)
                        .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                        .foregroundColor(.blue)
                        HStack{
                            Image(systemName: "lock.circle.fill")
                            SecureField("Password", text: self.$password)
                        }
                        .padding(12)
                        .frame(minWidth:0, maxWidth: 400)
                        .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                        .foregroundColor(.blue)
                        NavigationLink(destination: resetPasswordView()) {
                           HStack{
                               Text("Forgot Password?")
                           }
                        }
                        
                    }
                    HStack{
                        if (self.error != ""){
                            Text(self.error)
                                .font(.body)
                                .foregroundColor(.red)
                        }
                    }.padding(10)
                    
                    Spacer()
                    Button(action: self.signIn){
                       PrymaryButton(text: "LogIn", icon: "chevron.right.circle.fill")
                    }
                    
                  
                    NavigationLink(destination: signUpView()) {
                        VStack{
                            HStack {
                                Text("Still Not have Account?")
                                    .foregroundColor(.primary)
                            }
                            HStack{
                                Image(systemName: "person.crop.circle.fill.badge.plus")
                                Text("Sign Up Now")
                            }
                        }
                    }
                    Spacer()
                    
                }
                .padding(.horizontal, 32)
                //.offset(y: -self.keyboardValue)
                .animation(.spring())
                 .onAppear{/*
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let height = value.height
                        self.keyboardValue = height
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
                      
                        self.keyboardValue = 0
                    }
                */}
            }
           
        }
    
        
    }
}

struct signUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var keyboardValue : CGFloat = 0
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var data : DataStore
    
    func singUp(){
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                
                    self.email = ""
                    self.password = ""
            }
            
        }
    }
   var body: some View {
    GeometryReader { geometry in
        ScrollView {
            VStack{
                circleColorIconSystem(name: "person.crop.circle.fill.badge.plus")
                    .frame(width: geometry.size.width / 3.4, height: geometry.size.width / 4)
                
                Text("Sign Up")
                        .font(.largeTitle)
                        .foregroundColor(.blue)

                Text("Fill to start")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                VStack (spacing: 18){
                    HStack{
                        Image(systemName: "envelope.circle.fill")
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                        
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    
                    HStack{
                        Image(systemName: "lock.circle.fill")
                        SecureField("Pass", text: self.$password)
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                      
                }
              
                HStack{
                    if (self.error != ""){
                        Text(self.error)
                            .font(.body)
                            .foregroundColor(.red)
                    }
                }.padding(10)
                    Spacer()
                
                Button(action: {
                    if data.addUser(email: email) {
                        self.singUp()
                    }
                }){
                    PrymaryButton(text: "Sign Up", icon: "person.crop.circle.fill.badge.plus")
                }
                
                NavigationLink(destination: Text("Legal")) {
                    VStack{
                            HStack {
                                Text("Read or privacy policy")
                                    .foregroundColor(.primary)
                            }
                            HStack{
                                Image(systemName: "doc.plaintext")
                                Text("Legal")
                            }
                        }
                }
                Spacer()
            }
            .padding(.horizontal, 32)
            //.offset(y: -self.keyboardValue)
            .animation(.easeInOut(duration: 0.5))
             .onAppear{/*
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.keyboardValue = height
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
                  
                    self.keyboardValue = 0
                }
            */}
        }
    }
     
    }
        
}

struct resetPasswordView: View {
    @State var email: String = ""
    @State var error: String = ""
    @State var keyboardValue : CGFloat = 0
    
    @EnvironmentObject var session: SessionStore
    
    func resetPassword(){
        session.sendPasswordReset(email: email) { (error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
            }
        }
    }
   var body: some View {
     GeometryReader { geometry in
        ScrollView{
            VStack{
                circleColorIconSystem(name: "arrow.clockwise.circle.fill")
                    .frame(width: geometry.size.width / 3.4, height: geometry.size.width / 4)
                
                Text("Recovery Password")
                        .font(.largeTitle)
                        .foregroundColor(.blue)

                Text("Fill your email to recover account.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                VStack (spacing: 18){
                    HStack{
                        Image(systemName: "envelope.circle.fill")
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                    }
                    .padding(12)
                    .frame(minWidth:0, maxWidth: 400)
                    .background(RoundedRectangle(cornerRadius: 50).strokeBorder(Color.blue))
                    .foregroundColor(.blue)
                    Text("If you have an account you would receive an email on a couple of minutes.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                }
              
                HStack{
                    if (self.error != ""){
                        Text(self.error)
                            .font(.body)
                            .foregroundColor(.red)
                    }
                }.padding(10)
                    Spacer()
                
                Button(action: self.resetPassword){
                    PrymaryButton(text: "Recovery Password", icon: "arrow.clockwise.circle.fill")
                }
                
               
                Spacer()
            }
            .padding(.horizontal, 32)
            //.offset(y: -self.keyboardValue)
            .animation(.easeInOut(duration: 0.5))
            .onAppear{
                /*
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                    let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.keyboardValue = height
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
                    self.keyboardValue = 0
                }
                */
            }
        }
    }
    
    }
}
struct AuthView: View {
    var body: some View {
        NavigationView {
            SingInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}
