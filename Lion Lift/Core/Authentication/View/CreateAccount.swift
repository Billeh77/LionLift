//
//  createaccount.swift
//  Flights
//
//  Created by Jooyeon Lee on 11/14/24.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var showMessage: String? = nil

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.61, green: 0.80, blue: 0.92)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Title
                Text("Create New Account")
                    .font(.custom("Gilroy ☞", size: 24).weight(.bold))
                    .foregroundColor(.white)
                    .padding(.top, 50)

                Spacer()

                // Input Fields
                VStack(alignment: .leading, spacing: 10) {
                    Text("Columbia Email")
                        .font(.custom("Poppins", size: 13))
                        .foregroundColor(.white)

                    TextField("Enter your Columbia email", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .font(.custom("Poppins", size: 14))

                    Text("Phone Number")
                        .font(.custom("Poppins", size: 13))
                        .foregroundColor(.white)

                    TextField("Enter your phone number", text: $phoneNumber)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .font(.custom("Poppins", size: 14))

                    Text("Password")
                        .font(.custom("Poppins", size: 13))
                        .foregroundColor(.white)

                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .font(.custom("Poppins", size: 14))
                }
                .padding(.horizontal, 20)

                // Error or Success Message
                if let message = showMessage {
                    Text(message)
                        .font(.custom("Poppins", size: 14))
                        .foregroundColor(message.contains("successfully") ? .green : .red)
                        .padding(.top, 10)
                }

                Spacer()

                // Create Account Button
                Button(action: {
                    if email.isEmpty || phoneNumber.isEmpty || password.isEmpty {
                        showMessage = "All fields are required."
                    } else if !email.contains("@columbia.edu") {
                        showMessage = "Please enter a valid Columbia email."
                    } else {
                        showMessage = "Account created successfully!"
                        // Here, you can call a backend API to store the account details
                    }
                }) {
                    Text("Create Account")
                        .font(.custom("Roboto", size: 16).weight(.medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(red: 0, green: 0.22, blue: 0.40))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)

                Spacer()

                // Login Prompt
                HStack {
                    Text("Already have an account?")
                        .font(.custom("Roboto", size: 13).weight(.medium))
                        .foregroundColor(Color(red: 0.28, green: 0.28, blue: 0.28))

                    Button(action: {
                        // Navigate to Login screen
                        print("Navigate to Login")
                    }) {
                        Text("Login")
                            .font(.custom("Roboto", size: 13).weight(.medium))
                            .underline()
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            .previewDevice("iPhone 15 Pro")
    }
}
