//
//  CarpoolsViewModel.swift
//  Lion Lift
//
//  Created by Emile Billeh on 03/12/2024.
//

import Foundation
import Firebase
import Combine

class CarpoolsViewModel: ObservableObject {
    @Published var matches = [Match]()
    var matchDocumentReference: DocumentReference?
    
    init() {
        fetchMatches()
    }
    
    func fetchMatches() {
        guard let currentUserId = AuthViewModel.shared.userSession?.uid else {
            print("Error: User not authenticated.")
            return
        }

        // Get the current user's flight information
        COLLECTION_USERS.document(currentUserId).getDocument { document, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }

            guard let data = document?.data(),
                  let nextFlightAirport = data["nextFlightAirport"] as? String,
                  let nextFlightDateAndTime = data["nextFlightDateAndTime"] as? Timestamp,
                  let departing = data["departing"] as? Bool else {
                print("Error: Missing user flight data.")
                return
            }

            // Calculate the time range for matching (±30 minutes)
            let thirtyMinutesInSeconds: Double = 30 * 60
            let lowerBound = nextFlightDateAndTime.dateValue().addingTimeInterval(-thirtyMinutesInSeconds)
            let upperBound = nextFlightDateAndTime.dateValue().addingTimeInterval(thirtyMinutesInSeconds)

            // Perform the Firestore query
            COLLECTION_MATCHES
                .whereField("airport", isEqualTo: nextFlightAirport)
                .whereField("departing", isEqualTo: departing)
                .whereField("dateAndTime", isGreaterThanOrEqualTo: Timestamp(date: lowerBound))
                .whereField("dateAndTime", isLessThanOrEqualTo: Timestamp(date: upperBound))
                .addSnapshotListener { snapshot, error in
                    guard let changes = snapshot?.documentChanges else { return }
                    
                    for change in changes {
                        if let match = try? change.document.data(as: Match.self),
                           match.uids.contains(AuthViewModel.shared.userSession!.uid) {
                            
                            switch change.type {
                            case .added:
                                self.matches.append(match)
                                
                            case .modified:
                                if let index = self.matches.firstIndex(where: { $0.id == match.id }) {
                                    self.matches[index] = match
                                } else {
                                    self.matches.append(match)
                                }
                                
                            case .removed:
                                if let index = self.matches.firstIndex(where: { $0.id == match.id }) {
                                    self.matches.remove(at: index)
                                }
                            }
                        }
                    }
                    
                    self.matches.sort { $0.timestamp.dateValue() > $1.timestamp.dateValue() }
                }
        }
    }

}
