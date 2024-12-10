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

    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.61, green: 0.80, blue: 0.92)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    
                    // Modified NavigationLink to use value-based navigation
                    NavigationLink(value: viewModel.didAuthenticateUser) {
                        EmptyView() // Placeholder for the label if you only want to navigate based on value
                    }
                    .navigationDestination(for: Bool.self) { _ in
                        ProfilePhotoSelectorView() // Navigate to this view when didAuthenticateUser is true
                    }

                    Spacer()
                    
                    Text("Create New Account")
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
                        if validateEmail(email) {
                            viewModel.register(withEmail: email,
                                               password: password,
                                               phoneNumebr: phoneNumber,
                                               fullname: fullName,
                                               profileImageUrl: nil,
                                               nextFlightDateAndTime: "",
                                               nextFlightAirport: "",
                                               departing: false)
                        } else {
                            viewModel.errorMessage = "Please use a valid @columbia.edu email address."
                        }
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

                    Button {
                        dismiss()
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
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@columbia\.edu$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

