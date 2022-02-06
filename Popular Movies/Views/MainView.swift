//
//  MainView.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import SwiftUI

// There is nothing to comment out.

struct MainView: View {
    
    @State var navTitleText: String = ""
    
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .onAppear {
                    navTitleText = "Popular 🎬"
                }
            
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
                .onAppear {
                    navTitleText = "Favorite 🔥"
                }
        }
        .navigationTitle(navTitleText)
    }
}
