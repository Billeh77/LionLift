import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    @State private var errorMessage: String? = nil
    @State private var navigateToLogin = false
    @State private var showHidePassword = false

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
                    
                    Spacer()
                    
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
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text(viewModel.errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)

                    TextField("Columbia Email", text: $email)
                        .modifier(TextFieldModifier())
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .modifier(TextFieldModifier())
                    
                    ZStack(alignment: .trailing) {
                        if showHidePassword {
                            TextField("Password", text: $password)
                                .modifier(TextFieldModifier())
                        } else {
                            SecureField("Password", text: $password)
                                .modifier(TextFieldModifier())
                        }
                        
                        if !password.isEmpty {
                            Button {
                                showHidePassword.toggle()
                            } label: {
                                Image(systemName: showHidePassword ? "eye.slash.fill" : "eye.fill")
                                    .imageScale(.medium)
                                    .padding(.trailing, 38)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                    TextField("Full Name", text: $fullName)
                        .modifier(TextFieldModifier())

                    Button {
                        viewModel.register(withEmail: email, password: password, phoneNumebr: phoneNumber, fullname: fullName)
                    } label: {
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 360, height: 44)
                            .background(.white)
                            .cornerRadius(8)
                            .padding(.vertical)
                            .padding(.top)
                    }

                    Spacer()
                    
                    Spacer()

                    NavigationLink {
                        
                    } label: {
                        Text("Already have an account? ")
                            .font(.caption)
                            .foregroundStyle(.black)
                        
                        Text("Login")
                            .foregroundStyle(.white)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}
