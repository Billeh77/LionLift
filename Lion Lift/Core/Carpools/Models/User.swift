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
    let username: String
    let fullname: String
    let profileImageUrl: String?
    let email: String
    var latitude: Double
    var longitude: Double
    var deviceToken: String?
//    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id }
    
    static var dummyUser: User {
        return User(
            username: "Johnny",
            fullname: "John Doe",
            profileImageUrl: nil,
            email: "johndoe@example.com",
            latitude: 0,
            longitude: 0
        )
    }
}
