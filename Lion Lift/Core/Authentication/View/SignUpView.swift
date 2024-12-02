import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var navigateToLogin = false

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

                    CustomInputField(placeholder: "Columbia Email", text: $email)
                        .autocapitalization(.none)
                    CustomInputField(placeholder: "Phone Number", text: $phoneNumber)
                    CustomInputField(placeholder: "Password", isSecure: true, text: $password)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.custom("Roboto", size: 13))
                            .foregroundColor(.red)
                            .padding(.horizontal, 10)
                    }

                    CustomButton(
                        title: "Create Account",
                        backgroundColor: Color(red: 0, green: 0.22, blue: 0.40),
                        action: handleSignUp
                    )

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

    func handleSignUp() {
        errorMessage = nil

        guard !email.isEmpty, email.contains("@") else {
            errorMessage = "Please enter a valid email."
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Password cannot be empty."
            return
        }

        // Firebase
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = error.localizedDescription
                    return
                }
                navigateToLogin = true
            }
        }
    }
}
