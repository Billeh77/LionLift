//
//  ScheduledRideView.swift
//  Flights
//
//  Created by Layanne El Assaad on 11/14/24.
//

import SwiftUI

struct ScheduledRideView: View {
    var flightInfo: FlightInfo?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Scheduled Ride:")
                .font(.title)
                .padding(.bottom, 20)
            
            if let info = flightInfo {
                Text("Flight Number: \(info.flnr)")
                Text("Airline: \(info.airlineName ?? "N/A")")
                Text("Departure Airport: \(info.departureName ?? "N/A")")
                Text("Arrival Airport: \(info.arrivalName ?? "N/A")")
                Text("Scheduled Arrival Time: \(info.scheduledArrivalLocal ?? "N/A")")
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Scheduled Ride")
    }
}
