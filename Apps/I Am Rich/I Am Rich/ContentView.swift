//
//  ContentView.swift
//  I Am Rich
//
//  Created by Александр on 05.03.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        ZStack {
            Color(.systemTeal)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
            Text("I Am Rich")
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding()
            
            Image("diamond")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200.0, height: 200.0, alignment: .center)
                
            }
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 12 Pro Max")
        }
    }
}
