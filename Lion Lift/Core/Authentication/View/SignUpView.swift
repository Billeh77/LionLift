import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var errorMessage: String? = nil
    @State private var navigateToLogin = false

    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var profileImage: Image?
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.61, green: 0.80, blue: 0.92)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("Create New Account")
                        .font(.custom("Gilroy ☞", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, 50)
                    
                    Button(action: { imagePickerPresented.toggle() }, label: {
                        
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
                                .scaledToFill()
                                .frame(width: 180, height: 180)
                                .clipped()
                                .padding(.top, 44)
                                .foregroundColor(.black)
                        }
                    })
                    .sheet(isPresented: $imagePickerPresented,
                           onDismiss: loadImage, content: {
                        ImagePicker(showPicker: $imagePickerPresented, image: $selectedImage, sourceType: .photoLibrary)
                    })

                    CustomInputField(placeholder: "Columbia Email", text: $email)
                        .autocapitalization(.none)
                    CustomInputField(placeholder: "Phone Number", text: $phoneNumber)
                    CustomInputField(placeholder: "Password", isSecure: true, text: $password)
                    CustomInputField(placeholder: "Full Name", text: $fullName)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.custom("Roboto", size: 13))
                            .foregroundColor(.red)
                            .padding(.horizontal, 10)
                    }

                    Button {
                        viewModel.register(withEmail: email, password: password, phoneNumebr: phoneNumber, fullname: fullName)
                    } label: {
                        Text("Sign Up")
                    }

                    Spacer()

                    HStack(spacing: 5) {
                        Text("Already have an account?")
                            .font(.custom("Roboto", size: 13).weight(.medium))
                            .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
                        NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                            Text("Login")
                                .font(.custom("Roboto", size: 13).weight(.medium))
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                    .padding(.bottom, 50)
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}
