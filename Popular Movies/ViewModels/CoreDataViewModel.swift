//
//  CoreDataViewModel.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    let manager = CoreDataManager.shared
    @Published var movies: [MovieEntity] = []
    
    init() {
        getMovies()
    }
    
    func getMovies() {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        
        do {
            movies = try manager.context.fetch(request)
        } catch let error {
            print(String(describing: error))
        }
    }
    
    func addMovie(idForMovie id: Int64) {
        let newMoview = MovieEntity(context: manager.context)
        newMoview.id = id
        save()
        getMovies()
    }
    
    func deleteMovie(idForMovie id: Int64) {
        guard let movie = movies.first(where: {$0.id == id}) else {return}
        manager.context.delete(movie)
        save()
        getMovies()
    }
    
    func isFavorite(movie: Movie) -> Bool {
        
        if let id = movie.id {
            guard movies.first(where: {$0.id == id}) != nil else {
                return false
            }
        }
        
        return true
    }
    
    private func save() {
        manager.save()
    }
}
