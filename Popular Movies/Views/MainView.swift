//
//  MainView.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import SwiftUI

struct MainView: View {
    
    @State var navText: String = ""
    
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .onAppear {
                    navText = "Popular 🎬"
                }
            
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorite")
                }
                .onAppear {
                    navText = "Favorite 🔥"
                }
        }
        .navigationTitle(navText)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MoviesViewModel())
    }
}
