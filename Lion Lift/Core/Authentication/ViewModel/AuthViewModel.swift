//
//  AuthViewModel.swift
//  Lion Lift
//
//  Created by Adam Sherif on 12/2/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var errorMessage: String = ""
    
    static var shared = AuthViewModel()
    
    init() {
        self.userSession = Auth.auth().currentUser
        print("DEBUG: User session is \(self.userSession?.uid)")
    }
    
    func login(withEmail email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if let error = error {
                print("DEBUG: Failed to login with error: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
//            try await loadUserData()
            
            print("DEBUG: Did log user in")
            
        }
    }
    
    func register(withEmail email: String, password: String, phoneNumebr: String, fullname: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            
            if let error = error {
                print("DEBUG: Failed to register with error: \(error.localizedDescription)")
                self.errorMessage = error.localizedDescription
                return
                
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            print("DEBUG: Registered user sucessfully")
            
            let data = ["email": email,
                        "phoneNumber": phoneNumebr,
                        "fullname": fullname,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    print("DEBUG: Did upload user data...")
                }
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
//    func fetchUser(for uid: String) {
//        service.fetchUser(withUid: uid) { user in
//            self.currentUser = user
//            print("DEBUG: Fetched user is \(self.currentUser)")
//        }
//    }
}
