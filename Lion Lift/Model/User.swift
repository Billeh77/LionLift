//
//  User.swift
//  Carpools
//
//  Created by Emile Billeh on 14/11/2024.
//

import FirebaseFirestore
import Firebase
import MapKit

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let uid: String
    var username: String
    var fullname: String
    var profileImageUrl: String?
    var phoneNumber: String
    var email: String
    var nextFlightDateAndTime: Timestamp
    var nextFlightAirport: String
    var departing: Bool
    
    var isCurrentUser: Bool { return AuthViewModel.shared.currentUser?.uid == id }
    
    static var dummyUser: User {
        return User(
            uid: "",
            username: "Johnny",
            fullname: "John Doe",
            profileImageUrl: nil,
            phoneNumber: "0795602606",
            email: "johndoe@example.com",
            nextFlightDateAndTime: Timestamp(date: Date()),
            nextFlightAirport: "JFK",
            departing: true
        )
    }
}
