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
    @EnvironmentObject var coreDataVM: CoreDataViewModel
    @EnvironmentObject var moviesVM: MoviesViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading ,spacing: 20) {
                
                navigationTitle
                
                TabView {
                    ListView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .onAppear {
                            navTitleText = "Popular 🎬"
                            if moviesVM.favoriteMovies.isEmpty {
                                moviesVM.fromEntityToMovie(entities: coreDataVM.entities)
                            }
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
                .navigationBarHidden(true)
            }
            .background(.thickMaterial)
        }
    }
}

extension MainView {
    var navigationTitle: some View {
        Text(navTitleText)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CoreDataViewModel())
            .environmentObject(MoviesViewModel())
    }
}

