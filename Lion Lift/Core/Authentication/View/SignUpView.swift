//
//
//  Created by Chloe Lee on 11/14/24.
//


import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.61, green: 0.80, blue: 0.92)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Create New Account")
                        .font(.custom("Gilroy ☞", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, geometry.size.height * 0.05)
                    
                    CustomInputField(placeholder: "Columbia Email", text: $email)
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
                        Button(action: {
                            print("Navigate to Login")
                        }) {
                            Text("Login")
                                .font(.custom("Roboto", size: 13).weight(.medium))
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                    .padding(.bottom, geometry.size.height * 0.05)
                }
                .padding(.horizontal, geometry.size.width * 0.1)
            }
        }
    }
    
    func handleSignUp() {
        errorMessage = nil
        
        guard !email.isEmpty, email.contains("@") else {
            errorMessage = "Please enter a valid email."
            return
        }
        
        guard !phoneNumber.isEmpty, phoneNumber.count >= 10 else {
            errorMessage = "Please enter a valid phone number."
            return
        }
        
        
    }
}
