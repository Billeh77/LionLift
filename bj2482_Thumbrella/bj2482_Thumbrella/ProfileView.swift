import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Image
                if let profileImage = viewModel.profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.showImagePicker = true
                        }
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.showImagePicker = true
                        }
                }
                
                // User Information
                Text("Name: \(viewModel.userName)")
                Text("Age: \(viewModel.userAge)")
                Text("Phone: \(viewModel.userPhone)")
                Text("Email: \(viewModel.userEmail)")
                
                // Navigation Links for Edit Profile and Change Password
                VStack(spacing: 15) {
                    NavigationLink(destination: EditProfileView(viewModel: viewModel)) {
                        Text("Edit Profile")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Change Password")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(image: $viewModel.profileImage)
            }
        }
    }
}
