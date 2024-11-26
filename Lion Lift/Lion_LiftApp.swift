//
//  Lion_LiftApp.swift
//  Lion Lift
//
//  Created by Adam Sherif on 11/14/24.
//



import SwiftUI

@main
struct Lion_LiftApp: App {
    @State private var isLoading = true // Manage loading state
    
    var body: some Scene {
        WindowGroup {
            if isLoading {
                LoadingView() // Loading View
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                        }
                    }
            } else {
                LoginView()
            }
        }
    }
}
//import SwiftUI
//
//@main
//struct Lion_LiftApp: App {
//    var body: some Scene {
//        WindowGroup {
//            MainTabView()
//        }
//    }
//}
