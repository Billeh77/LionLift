import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var isLoading: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.61, green: 0.80, blue: 0.92)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Login")
                        .font(.custom("Poppins", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, geometry.size.height * 0.05)

                    CustomInputField(placeholder: "Columbia email", text: $email)
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
                    
                    Button(action: {
                        print("Forgot password tapped")
                    }) {
                        Text("Forgot password?")
                            .font(.custom("Roboto", size: 13).weight(.medium))
                            .foregroundColor(.white)
                            .underline()
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 5) {
                        Text("Don’t have an account?")
                            .font(.custom("Roboto", size: 13).weight(.medium))
                            .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))
                        Button(action: {
                            print("Sign Up tapped")
                        }) {
                            Text("Sign Up")
                                .font(.custom("Roboto", size: 13).weight(.medium))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, geometry.size.height * 0.05)
                }
                .padding(.horizontal, geometry.size.width * 0.1)
            }
        }
    }
    
    func handleLogin() {
        errorMessage = nil
        
        guard !email.isEmpty, email.contains("@") else {
            errorMessage = "Please enter a valid email."
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Password cannot be empty."
            return
        }
        
        isLoading = true
        NetworkManager.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    print("Login successful!")
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
