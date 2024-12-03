//
//  Match.swift
//  Carpools
//
//  Created by Emile Billeh on 14/11/2024.
//

import FirebaseFirestore
import Firebase
import MapKit

struct Match: Identifiable, Decodable {
    @DocumentID var id: String?
    let uids: [String]
    let usersFullNames: [String]
    let departureAirport: String
    let arrivalAirport: String
    let departureTerminal: String
    let arrivalTerminal: String
    let meetUpDateAndTime: Timestamp
    let meetUpLocation: String
    let arrival: Bool
    let departure: Bool
//    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    
    static var dummyMatch: Match {
        return Match(
            uids: [],
            usersFullNames: ["John Doe, Haley Smith"],
            departureAirport: "John F. Kennedy",
            arrivalAirport: "John F. Kennedy",
            departureTerminal: "Terminal 5",
            arrivalTerminal: "Terminal 5",
            meetUpDateAndTime: Timestamp(date: Date()),
            meetUpLocation: "201 W 105th St",
            arrival: true,
            departure: false)
    }
}
