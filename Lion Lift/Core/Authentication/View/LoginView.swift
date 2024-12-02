import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var isLoading: Bool = false

    @State private var navigateToSignup = false
    @State private var navigateToForgotPassword = false
    @State private var navigateToMainTab = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.61, green: 0.80, blue: 0.92)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("Login")
                        .font(.custom("Poppins", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, 50)

                    CustomInputField(placeholder: "Email", text: $email)
                        .autocapitalization(.none)
                    CustomInputField(placeholder: "Password", isSecure: true, text: $password)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.custom("Roboto", size: 13))
                            .foregroundColor(.red)
                            .padding(.horizontal, 10)
                    }

                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        CustomButton(
                            title: "Login",
                            backgroundColor: Color(red: 0, green: 0.22, blue: 0.40),
                            action: handleLogin
                        )
                    }

                    Spacer()

                    HStack(spacing: 5) {
                        Text("Don’t have an account?")
                            .font(.custom("Roboto", size: 13).weight(.medium))
                            .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
                        NavigationLink(destination: SignUpView(), isActive: $navigateToSignup) {
                            Text("Sign Up")
                                .font(.custom("Roboto", size: 13).weight(.medium))
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }

    func handleLogin() {
        errorMessage = nil
        isLoading = true

        guard !email.isEmpty else {
            errorMessage = "Email cannot be empty."
            isLoading = false
            return
        }

        guard !password.isEmpty else {
            errorMessage = "Password cannot be empty."
            isLoading = false
            return
        }

        // Firebase
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = error.localizedDescription
                    return
                }
                navigateToMainTab = true
            }
        }
    }
}
