// Report.swift
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth // 추가된 부분

struct Report: Identifiable, Codable {
    @DocumentID var id: String?
    let reporterId: String
    let reportedUserId: String
    let reason: String
    let timestamp: Timestamp

    static func submitReport(reportedUserId: String, reason: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let reporterId = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No current user"])))
            return
        }

        let data: [String: Any] = [
            "reporterId": reporterId,
            "reportedUserId": reportedUserId,
            "reason": reason,
            "timestamp": Timestamp(date: Date())
        ]

        Firestore.firestore().collection("reports").addDocument(data: data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
