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
    let airport: String
    let dateAndTime: Timestamp
    let departing: Bool
    
    static var dummyMatch: Match {
        return Match(
            uids: [],
            usersFullNames: ["John Doe, Haley Smith"],
            airport: "John F. Kennedy",
            dateAndTime: Timestamp(date: Date()),
            departing: false)
    }
}
