import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Profile Details
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome, User!")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Email: user@example.com")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(10)
                .shadow(radius: 2)
                
                // Navigation Links
                VStack(spacing: 12) {
                    NavigationLink(destination: ProfileSettingsView()) {
                        Text("Profile Settings")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change Password")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: CustomerSupportView()) {
                        Text("Customer Support")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
