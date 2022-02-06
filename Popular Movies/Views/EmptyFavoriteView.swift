//
//  EmptyFavoriteView.swift
//  Popular Movies
//
//  Created by Fatih Kilit on 6.02.2022.
//

import SwiftUI

struct EmptyFavoriteView: View {
    var body: some View {
        
        VStack {
            Text("Your favorite list is empty.")
                .font(.title)
                .fontWeight(.bold)
                .shadow(radius: 4, y: 10)
                .frame(width: 350, height: 120)
                .padding(10)
                .background(.white)
                .cornerRadius(20)
                .shadow(radius: 10)
            
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.thickMaterial)
    }
}

struct EmptyFavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyFavoriteView()
    }
}
