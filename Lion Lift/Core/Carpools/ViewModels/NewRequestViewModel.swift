//
//  NewRequestViewModel.swift
//  Lion Lift
//
//  Created by Emile Billeh on 05/12/2024.
//

import Foundation
import Firebase
import SwiftUI


class NewRequestViewModel {

    func sendRequest(messageText: String, receivingUid: String) {
        guard let currentUser = AuthViewModel.shared.currentUser else { return }
        
        let data: [String: Any] = ["uid": currentUser.uid,
                    "fullname": currentUser.fullname,
                    "airport": currentUser.nextFlightAirport,
                    "flightDateAndTime": currentUser.nextFlightDateAndTime,
                    "departing": currentUser.departing,
                    "message": messageText]
        
        Firestore.firestore().collection("users").document(receivingUid).collection("requests").addDocument(data: data) { error in
            if let error = error {
                print("error uploading request \(error.localizedDescription)")
            }
        }
        
        
    }
}

