//
//  HomeView.swift
//  Lion Lift
//
//  Created by Adam Sherif on 11/14/24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.6413, longitude: -73.7781), // JFK Airport coordinates
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Adjust for desired zoom level
        )
    @State private var isShowFlight = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.top)
            
            Button {
                isShowFlight.toggle()
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.white)
                        .shadow(radius: 9.0)
                    Image(systemName: "airplane.departure")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }
                .padding()
            }
            .sheet(isPresented: $isShowFlight) {
                FlightSearchView()
            }
        }
    }
}

#Preview {
    HomeView()
}
