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
    let uid: String
    let fullName: String
    let airport: String
    let flightDateAndTime: Timestamp
    let departing: Bool
    let message: String
//    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    
//    static var dummyRequest: Request {
//        return Request(
//            uids: [],
//            usersFullNames: ["John Doe, Haley Smith"],
//            departureAirport: "John F. Kennedy",
//            arrivalAirport: "John F. Kennedy",
//            departureTerminal: "Terminal 5",
//            arrivalTerminal: "Terminal 5",
//            departureDateAndTime: Timestamp(date: Date()),
//            meetUpLocation: "201 W 105th St",
//            arrival: true,
//            departure: false)
//    }
}
