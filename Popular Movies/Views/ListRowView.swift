//
//  ListRowView.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import SwiftUI

struct ListRowView: View {
    
    @EnvironmentObject var moviesVM: MoviesViewModel
    
    var movie: Movie
    
    var body: some View {
        
        ZStack {
            HStack(spacing: 16) {
                
                movieImageView(fromUrl: URL(string: moviesVM.getImageURLString(movie: movie, imageSize: .small)))
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    movieTitleView
                    
                    movieReleaseDateView
                    
                    movieRateView
                        .overlay(overlayView.mask(movieRateView))
                
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
    }
}

extension ListRowView {
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
                    .frame(width: geometry.size.width / 10 * CGFloat(movie.voteAverage ?? 0.0))
            }
        }
    }
    
    var movieTitleView: some View {
        Text(movie.originalTitle ?? "")
            .font(.headline)
            .fontWeight(.bold)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var movieReleaseDateView: some View {
        Text("Release Date: \(movie.releaseDate ?? "")")
            .font(.subheadline)
            .fontWeight(.medium)
    }
    
    func movieImageView(fromUrl url: URL?) -> some View {
        
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .padding(.horizontal)
                .cornerRadius(10)
                .shadow(radius: 10)
                
        } placeholder: {
            Image(systemName: "rectangle.fill")
                .resizable()
                .foregroundColor(.white)
                .scaledToFill()
                .frame(width: 100, height: 100)
                .padding(.horizontal)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
    
}

/*
struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(movie: Result(backdropPath: nil, genreIDS: nil, id: nil, originalTitle: nil, overview: nil, posterPath: nil, releaseDate: nil, voteAverage: nil))
            .environmentObject(MoviesViewModel())
    }
}
*/
