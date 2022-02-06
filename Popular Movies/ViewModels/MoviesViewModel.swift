//
//  MoviesViewModel.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import Foundation

class MoviesViewModel: ObservableObject {
    
    @Published var movieModel: MovieModel?
    @Published var movies: [Movie] = []
    
    init() {
        getAllMovies()
    }
    
    func getAllMovies() {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e112ed72df8da5c3b38e4e6579896bc6&language=en-US&page=1") else {return}
        
        DownloaderManager.shared.downloadData(fromURL: url) { data in
            
            if let data = data {
                guard let returnedMovie = try? JSONDecoder().decode(MovieModel.self, from: data) else {return}
                guard let returnedResults = returnedMovie.results else {return}
                
                // Affecting UI. It has to be work on main thread.
                DispatchQueue.main.async { [weak self] in
                    self?.movieModel = returnedMovie
                    self?.movies = returnedResults
                }
            }
        }
    }
    
    func getMovieByMovieEntity(movieEntity: MovieEntity) -> Movie {
        guard let movie = movies.first(where: {$0.id == Int(movieEntity.id)}) else {
            return Movie(backdropPath: nil, genreIDS: nil, id: nil, originalTitle: nil, overview: nil, posterPath: nil, releaseDate: nil, voteAverage: nil)
            }
        
        return movie
    }
    
    func getImageURLString(movie: Movie, imageSize: ImageSize) -> String {
        let baseURLSmall = "https://image.tmdb.org/t/p/w500"
        let baseURLLarge = "https://image.tmdb.org/t/p/original"
        
        let endpoint = movie.backdropPath ?? ""
        
        if imageSize == .small {
            return baseURLSmall + endpoint
        }
        else {
            return baseURLLarge + endpoint
        }
    }
}

enum ImageSize {
    case small
    case large
}
