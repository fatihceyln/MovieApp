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
    @Published var currentPage: Int = 1 {
        didSet {
            getAllMovies(byPage: currentPage)
        }
    }
    
    @Published var favoriteMovies: [Movie] = []
    @Published var genres: [Genre] = []
    
    init() {
        getAllMovies(byPage: currentPage)
        getGenres()
    }
    
    func fromEntityToMovie(entities: [MovieEntity]) {
        favoriteMovies.removeAll()
        for entity in entities {
            getMovieUsingID(idForMovie: Int(entity.id))
        }
    }
    
    func getMovieUsingID(idForMovie id: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=e112ed72df8da5c3b38e4e6579896bc6&language=en-US") else {return}
        
        DownloaderManager.shared.downloadData(fromURL: url) { data in
            if let data = data {
                guard let returnedMovie = try? JSONDecoder().decode(Movie.self, from: data) else {
                    return}
                print(returnedMovie)
                DispatchQueue.main.async { [weak self] in
                    self?.favoriteMovies.append(returnedMovie)
                }
            }
        }
    }
    
    func getAllMovies(byPage page: Int) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e112ed72df8da5c3b38e4e6579896bc6&language=en-US&page=\(page)") else {return}
        
        DownloaderManager.shared.downloadData(fromURL: url) { data in
            
            if let data = data {
                guard let returnedMovie = try? JSONDecoder().decode(MovieModel.self, from: data) else {return}
                guard let returnedResults = returnedMovie.results else {return}
                
                // Affecting UI. It has to be work on main thread.
                DispatchQueue.main.async { [weak self] in
                    self?.movieModel = returnedMovie
                    self?.movies.append(contentsOf: returnedResults)
                }
            }
        }
    }
    
    func shouldLoadMoreData(id: Int) -> Bool {
        return id == movies[movies.count - 3].id
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
    
    func getGenres() {
        guard let genreURL = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=e112ed72df8da5c3b38e4e6579896bc6&language=en-US") else {return}
        
        DownloaderManager.shared.downloadData(fromURL: genreURL) { data in
            
            if let data = data {
                guard let returnedGenreModel = try? JSONDecoder().decode(GenreModel.self, from: data) else {
                    print("error")
                    return}
                DispatchQueue.main.async { [weak self] in
                    self?.genres = returnedGenreModel.genres
                }
            }
        }
    }
    
    func returnGenreString(id: Int) -> String {
        return genres.first(where: {$0.id == id})?.name ?? ""
    }
}

enum ImageSize {
    case small
    case large
}
