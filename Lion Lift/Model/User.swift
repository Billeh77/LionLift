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
    let username: String
    let fullname: String
    let profileImageUrl: String?
    let phoneNumber: String
    let email: String
    var isCurrentUser: Bool { return AuthViewModel.shared.currentUser?.uid == id }
    
    static var dummyUser: User {
        return User(
            uid: "",
            username: "Johnny",
            fullname: "John Doe",
            profileImageUrl: nil,
            phoneNumber: "0795602606",
            email: "johndoe@example.com"
        )
    }
}
