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
                    // Title for creating a new account at the top
                    Text("Create New Account")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top, 32)

                    // Display error message if there is one
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }

                    // Email input field
                    TextField("Columbia Email", text: $email)
                        .modifier(TextFieldModifier())

                    // Phone number input field
                    TextField("Phone Number", text: $phoneNumber)
                        .modifier(TextFieldModifier())

                    // Password field with show/hide functionality
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

                    // Full name input field
                    TextField("Full Name", text: $fullName)
                        .modifier(TextFieldModifier())

                    // Sign Up button
                    Button {
                        // Validate email and proceed with registration
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
                            // Show error message for invalid email
                            viewModel.errorMessage = "Please use a valid @columbia.edu email address."
                        }
                    } label: {
                        Text("Sign Up")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 360, height: 44)
                            .background(Color(red: 0/255, green: 56/255, blue: 101/255)) // Background color #003865
                            .cornerRadius(8)
                            .padding(.top, 20) // Adjust top padding for button
                    }

                    Spacer()  // Push content to the top

                    // Login link for users who already have an account
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
                    .padding(.bottom, 16)
                }
                .padding(.horizontal, 20) // Add some horizontal padding for better spacing
            }
        }
    }
    
    // Function to validate email using a regex for columbia.edu emails
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@columbia\.edu$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

// Preview for the SignUpView
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthViewModel()) // Mock AuthViewModel for preview
    }
}
