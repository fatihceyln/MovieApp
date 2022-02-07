//
//  Popular_MoviesApp.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import SwiftUI

@main
struct Popular_MoviesApp: App {
    
    @StateObject var moviesVM = MoviesViewModel()
    @StateObject var coreDataVM = CoreDataViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(moviesVM)
                .environmentObject(coreDataVM)
        }
    }
}
