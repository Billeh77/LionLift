//
//  MatchesViewModel.swift
//  Lion Lift
//
//  Created by Emile Billeh on 03/12/2024.
//

import Foundation
import Firebase
import Combine

class MatchesViewModel: ObservableObject {
    @Published var matches = [Match]()
    var matchDocumentReference: DocumentReference?
    
    init() {
        fetchChannels()
    }
    
    func fetchChannels() {
        COLLECTION_MATCHES.addSnapshotListener { snapshot, error in
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
