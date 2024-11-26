
//
//  HomeView.swift
//  Flights
//
//  Created by Chloe Lee on 11/14/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            // Background Color (Full screen)
            Color(red: 0, green: 0.22, blue: 0.40)
                .edgesIgnoringSafeArea(.all) // Ensures the background covers the entire screen
            
            VStack(spacing: 20) {
                // Logo
                Image("lion") // Ensure this image is added to Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 112, height: 112) // Specify logo size
                
                // Title
                Text("Lion Lyft")
                    .font(.custom("Poppins", size: 50).weight(.bold))
                    .foregroundColor(.white)
            }
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewDevice("iPhone 15 Pro")
    }
}
