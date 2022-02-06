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
            
            if coreDataVM.movies.count == 0 {
                EmptyFavoriteView()
            }
            else {
                List {
                    ForEach(coreDataVM.movies) { movie in
                        NavigationLink {
                            DetailView(movie: moviesVM.getMovieByMovieEntity(movieEntity: movie))
                        } label: {
                            ListRowView(movie: moviesVM.getMovieByMovieEntity(movieEntity: movie))
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
