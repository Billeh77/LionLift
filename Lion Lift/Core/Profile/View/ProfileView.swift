import SwiftUI

struct ProfileView: View {
    
    @State private var logoutHit = false
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Profile Details
                
                if let currentUser = viewModel.currentUser {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome, \(currentUser.fullname)!")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Email: \(currentUser.email)")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
                
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        logoutHit.toggle()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                            .foregroundStyle(.black)
                    }
                    .alert("Are you sure you want to log out?", isPresented: $logoutHit) {
                                    Button("Yes, Logout", role: .destructive) {
                                        viewModel.signOut()
                                    }
                                    Button("Cancel", role: .cancel) {
                                        print("Logout canceled")
                                    }
                                }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
