//
//  forgotpassword.swift
//  Flights
//
//  Created by Chloe Lee on 11/14/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.61, green: 0.80, blue: 0.92)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Header Text
                Text("Forgot Password")
                    .font(.custom("Poppins", size: 24).weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.top, 50)

                Spacer()

                // Input Field for Email
                VStack(alignment: .leading, spacing: 10) {
                    Text("Email Address")
                        .font(.custom("Poppins", size: 16).weight(.semibold))
                        .foregroundColor(.white)

                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .foregroundColor(.black)
                        .font(.custom("Poppins", size: 14))
                }
                .padding(.horizontal, 20)

                Spacer()

                // Submit Button
                Button(action: {
                    // Handle forgot password logic here
                    print("Reset password link sent to \(email)")
                }) {
                    Text("Send Reset Link")
                        .font(.custom("Poppins", size: 16).weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(red: 0, green: 0.22, blue: 0.40))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .previewDevice("iPhone 15 Pro")
    }
}
