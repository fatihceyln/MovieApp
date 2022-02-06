//
//  DownloaderManager.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import Foundation

class DownloaderManager{
    
    //Singleton
    static let shared = DownloaderManager()
    
    func downloadData(fromURL url: URL, completionHandler: @escaping(_ data: Data?) -> ()) {
        
        // dataTask is background thread by default.
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil,
                response.statusCode >= 200 && response.statusCode < 300 else {
                    print("Error occured while downloading data!")
                    completionHandler(nil)
                    return
                }
            
            completionHandler(data)
            
        }
        .resume() // for starting session
    }
}
