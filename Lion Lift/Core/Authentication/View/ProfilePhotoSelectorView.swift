//
//  ProfilePhotoSelectorView.swift
//  Lion Lift
//
//  Created by Adam Sherif on 12/3/24.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.80, blue: 0.92)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                
                Spacer()
                
                Text("Add a profile photo")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                
                Button {
                    showImagePicker.toggle()
                } label: {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipShape(Circle())
                    } else {
                        Image("plus_photo")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipShape(Circle())
                        
                    }
                }
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
                if let selectedImage = selectedImage {
                    Button {
                        print("DEBUG: Add image button hit...")
                        viewModel.uploadProfileImage(selectedImage)
                    } label: {
                        Text("Continue")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 360, height: 44)
                            .background(.white)
                            .cornerRadius(8)
                            .padding(.vertical)
                            .padding(.top)
                    }
                }
                
                

                Spacer()
                
                Spacer()

            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}

#Preview {
    ProfilePhotoSelectorView()
}
