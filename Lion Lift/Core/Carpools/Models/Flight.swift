//
//  Flight.swift
//  Carpools
//
//  Created by Emile Billeh on 14/11/2024.
//

import FirebaseFirestore
import Firebase
import MapKit

struct Flight: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    let departureAirport: String
    let arrivalAirport: String
    let departureTerminal: String
    let arrivalTerminal: String
    let departureDateAndTime: Timestamp
    let arrivalDateAndTime: Timestamp
    let arrival: Bool
    let departure: Bool
//    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    
    static var dummyFlight: Flight {
        return Flight(
            uid: "",
            departureAirport: "JFK",
            arrivalAirport: "Queen Alia Int Airport",
            departureTerminal: "Terminal 5",
            arrivalTerminal: "Terminal A",
            departureDateAndTime: Timestamp(date: Date()),
            arrivalDateAndTime: Timestamp(date: Date()),
            arrival: true,
            departure: false)
    }
}
