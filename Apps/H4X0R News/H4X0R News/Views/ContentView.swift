//
//  ContentView.swift
//  H4X0R News
//
//  Created by Александр on 07.03.2021.
//

import SwiftUI

struct ContentView: View {
    
    // Subscribe to listen to networkManager
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        // Creates a navigation stack
        NavigationView {
            // UITableView
            List(networkManager.posts) { post in
                // For single one post in posts...
                HStack {
                    Text(String(post.points))
                    Text(post.title)
                }
            }
            .navigationBarTitle("H4X0R News")
        }
        // It is like ViewDidLoad
        .onAppear(perform: {
            self.networkManager.fetchData() // Trigger to fetch data as the view loaded 
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}


