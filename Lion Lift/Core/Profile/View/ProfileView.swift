import SwiftUI
import Kingfisher
import Firebase

struct ProfileView: View {
    
    @State private var logoutHit = false
    @State private var editProfileSheet = false
    @State private var customerSupport = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 20) {
                
                if let user = viewModel.currentUser {
                    
                    Text("Welcome \(user.fullname)!")
                        .font(.largeTitle)
                        .bold()
                    
                    
                    ZStack(alignment: .topTrailing) {
                        VStack(alignment: .leading, spacing: 8) {
                            
                            HStack(spacing: 20) {
                                if let profileImageUrl = user.profileImageUrl {
                                    KFImage(URL(string: profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                        .frame(width: 80, height: 80)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Email: \(user.email)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    
                                    Text("Phone Number: \(user.phoneNumber)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        
                        Button {
                            editProfileSheet.toggle()
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 4)
                                .padding(5)
                                .padding(.horizontal, 5)
                                
                        }
                        .fullScreenCover(isPresented: $editProfileSheet) {
                            EditProfileSheet()
                        }
                        
                    }
                }
                
                Text("Upcoming flights:")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                if let user = viewModel.currentUser {
                    
                    if user.nextFlightAirport.isEmpty {
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Text("You have no upcoming flights.")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Spacer()
                        }
                    } else {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("\(user.nextFlightAirport) Airport ")
                                .foregroundStyle(.black)
                                .bold()
                                .font(.subheadline)
                            
                            Text("Departure: \(formatFirebaseTimestamp(user.nextFlightDateAndTime))")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                }
                
                
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        customerSupport.toggle()
                    } label: {
                        Image(systemName: "phone.bubble.fill")
                            .foregroundColor(.black)
                    }
                    .fullScreenCover(isPresented: $customerSupport) {
                        CustomerSupportView()
                    }
                }
                
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
        .onAppear() {
            viewModel.fetchUser()

        }
    }
    
    func formatFirebaseTimestamp(_ timestamp: Timestamp?) -> String {
        guard let timestamp = timestamp else { return "N/A" }
        let date = timestamp.dateValue()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ProfileView()
}

