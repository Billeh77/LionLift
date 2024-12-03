//
//  Request.swift
//  Lion Lift
//
//  Created by Emile Billeh on 02/12/2024.
//

import FirebaseFirestore
import Firebase
import MapKit

struct Request: Identifiable, Decodable {
    @DocumentID var id: String?
    let uids: [String]
    let usersFullNames: [String]
    let departureAirport: String
    let arrivalAirport: String
    let departureTerminal: String
    let arrivalTerminal: String
    let departureDateAndTime: Timestamp
    let meetUpLocation: String
    let arrival: Bool
    let departure: Bool
//    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    
    static var dummyRequest: Request {
        return Request(
            uids: [],
            usersFullNames: ["John Doe, Haley Smith"],
            departureAirport: "John F. Kennedy",
            arrivalAirport: "John F. Kennedy",
            departureTerminal: "Terminal 5",
            arrivalTerminal: "Terminal 5",
            departureDateAndTime: Timestamp(date: Date()),
            meetUpLocation: "201 W 105th St",
            arrival: true,
            departure: false)
    }
}
