//
//  MainView.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import SwiftUI

// There is nothing to comment out.

struct ListView: View {
    
    @EnvironmentObject var moviesVM: MoviesViewModel
    var body: some View {
        List {
            ForEach(moviesVM.movies) { movie in
                NavigationLink {
                    DetailView(movie: movie)
                } label: {
                    ListRowView(movie: movie)
                        .onAppear {
                            if let id = movie.id {
                                if moviesVM.shouldLoadMoreData(id: id) {
                                    moviesVM.currentPage += 1
                                }
                            }
                        }
                }
            }
        }
        .padding(.top, 30)
        .listStyle(.plain)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(MoviesViewModel())
    }
}
