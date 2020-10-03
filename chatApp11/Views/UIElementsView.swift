//
//  ChatAppApp.swift
//  Shared
//
//  Created by Francisco Misael Landero Ychante on 28/09/20.
//


import SwiftUI


struct ThemeColors {
     static let blueOne = Color(red: 26  / 255, green: 212 / 255, blue: 253 / 255)
     static let blueTwo = Color(red: 30 / 255, green: 99 / 255, blue: 239 / 255)
}

struct circleColorIcon : View {
    var body: some View {
           Image(systemName: "message.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [ThemeColors.blueOne, ThemeColors.blueTwo]), startPoint: .top, endPoint: .bottom) )
            .clipShape(Circle())
            .foregroundColor(.white)
       }
}

struct circleColorIconSystem : View {
    var name : String
    var body: some View {
           Image(systemName: name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [ThemeColors.blueOne, ThemeColors.blueTwo]), startPoint: .top, endPoint: .bottom) )
            .clipShape(Circle())
       }
}

struct PrymaryButton : View {
    let text : String
    let icon : String
    var body: some View {
            HStack{
                Image(systemName: icon)
                Text(text)
            }
            .font(.headline)
            .frame(minWidth:0, maxWidth: 300)
            .frame(height:50)
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [ThemeColors.blueOne, ThemeColors.blueTwo]), startPoint: .top, endPoint: .bottom) )
            .cornerRadius(50)
       }
}

struct CancelButton : View {
    let text : String
    let icon : String
    var body: some View {
            HStack{
                Image(systemName: icon)
                Text(text)
            }
            .font(.headline)
            .frame(minWidth:0, maxWidth: 300)
            .frame(height:50)
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.pink,.red]), startPoint: .top, endPoint: .bottom) )
            .cornerRadius(50)
       }
}

struct UIElementsView: View {
    var body: some View {
        Group{
            VStack(){
                circleColorIconSystem(name: "person.crop.circle.fill.badge.plus")
                .frame(width: 100, height: 100)
                circleColorIcon()
                .frame(width: 100, height: 100)
                PrymaryButton(text: "Ingresar", icon: "plus")
            }
        }
        
    }
}

struct UIElementsView_Previews: PreviewProvider {
    static var previews: some View {
        UIElementsView()
    }
}
