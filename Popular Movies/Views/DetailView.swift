//
//  DetailView.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var moviesVM: MoviesViewModel
    @EnvironmentObject var coreDataVM: CoreDataViewModel
    let movie: Movie
    @State var isFavorite: Bool = false
    @State var currentAmount: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                
                movieImage(fromUrl: URL(string: moviesVM.getImageURLString(movie: movie, imageSize: .small)))
                
                
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        
                        movieTitle
                        
                        HStack {
                            movieRateView.overlay(overlayView.mask(movieRateView))
                            
                            movieReleaseDate
                        }
                    }
                    
                    Spacer()
                    
                    heartButton
                    
                }
                .padding()
                .background(.thickMaterial)
                .cornerRadius(10)
                .shadow(radius: 10)
                
                Divider()
                
                overview
            }
            .padding()
        }
        .navigationTitle("Details")
        .ignoresSafeArea(edges: .horizontal)
        .background(.ultraThinMaterial)
        .onAppear {
            isFavorite = coreDataVM.isFavorite(movie: movie)
        }
    }
}

extension DetailView {
    var movieRateView: some View {
        HStack(spacing: 0) {
            ForEach(1..<6, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.gray)
            }
        }
    }
    
    var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: geometry.size.width / 10 * CGFloat(movie.voteAverage ?? 5.0))
            }
        }
    }
    
    
    func movieImage(fromUrl url: URL?) -> some View {
        
        AsyncImage(url: url) { image in
            image
                .resizable()
        } placeholder: {
            Rectangle()
                .fill(.thickMaterial)
        }
        .scaledToFill()
        .frame(width: 400, height: 350)
        .cornerRadius(10)
        .padding(5)
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(radius: 10)
        .scaleEffect(1 + currentAmount)
        .gesture(
            MagnificationGesture()
                .onChanged { value in
                    if value > 1 {
                        currentAmount = value - 1
                    }
                    else {
                        currentAmount = 0
                    }
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        currentAmount = 0
                    }
                }
        )
        .zIndex(1.0)
    }
    
    
    var movieTitle: some View {
        Text(movie.originalTitle ?? "")
            .font(.title)
            .fontWeight(.semibold)
    }
    
    var movieReleaseDate: some View {
        Text(movie.releaseDate ?? "10-10-2000")
            .font(.subheadline)
    }
    
    var overview: some View {
        Text(movie.overview ?? "")
            .font(.body)
            .multilineTextAlignment(.leading)
            .padding()
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(radius: 10)
    }
    
    var heartButton: some View {
        Button {
            isFavorite.toggle()
            
            if isFavorite {
                coreDataVM.addMovie(idForMovie: Int64(movie.id ?? 0))
            }
            else {
                coreDataVM.deleteMovie(idForMovie: Int64(movie.id ?? 0))
            }
            
        } label: {
            ZStack {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(5)
                    .background(.ultraThickMaterial)
                    .cornerRadius(5)
                    .shadow(radius: 3)
                    .tint(isFavorite ? .red : .gray)
            }
        }
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(movie: Result(backdropPath: nil, genreIDS: nil, id: nil, originalTitle: nil, overview: nil, posterPath: nil, releaseDate: nil, voteAverage: nil))
            .environmentObject(MoviesViewModel())
            .environmentObject(CoreDataViewModel())
    }
}
