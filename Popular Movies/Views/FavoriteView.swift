//
//  FavoriteView.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var coreDataVM: CoreDataViewModel
    @EnvironmentObject var moviesVM: MoviesViewModel
    
    var body: some View {
        
        VStack {
            
            if moviesVM.favoriteMovies.isEmpty {
                EmptyFavoriteView()
            }
            else {
                List {
                    // We're giving MovieEntity array 'cause favorited movies are saved into that array.
                    ForEach(moviesVM.favoriteMovies) { movie in
                        NavigationLink {
                            DetailView(movie: movie)
                        } label: {
                            ListRowView(movie: movie)
                        }
                    }
                }
                .padding(.top, 30)
                .listStyle(.plain)
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(CoreDataViewModel())
            .environmentObject(MoviesViewModel())
    }
}
