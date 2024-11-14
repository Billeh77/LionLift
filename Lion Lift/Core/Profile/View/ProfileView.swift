//
//  ProfileView.swift
//  Lion Lift
//
//  Created by Adam Sherif on 11/14/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        NavigationStack {
            Text("Profile code goes here")
            NavigationLink {
                ProfileSettingsView()
            } label: {
                Text("Profile Settings")
            }
            
            NavigationLink(destination: ChangePasswordView()) {
                                Text("Change Password")
                            }
            NavigationLink(destination: CustomerSupportView()) {
                                Text("Customer Support")
                            }
        }
    }
}

#Preview {
    ProfileView()
}
