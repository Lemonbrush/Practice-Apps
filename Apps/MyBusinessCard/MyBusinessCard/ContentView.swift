//
//  ContentView.swift
//  MyBusinessCard
//
//  Created by Александр on 05.03.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("MyPhoto")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 250.0)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                
                Text("Alexander")
                    .font(Font.custom("KaushanScript-Regular", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                
                Divider()
                
                VStack {
                    InfoView(text: "+44 123 456 789", imageName: "phone.fill")
                    InfoView(text: "aa_rubtsov@mail.ru", imageName: "envelope.fill")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12 Pro Max")
    }
}
