import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var isNavigatingToVerify: Bool = false // Navigation state
    @State private var verificationCode: String = "" // Generated code

    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.80, blue: 0.92)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Forgot Password")
                    .font(.custom("Poppins", size: 24).weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.top, 50)

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

                Button(action: {
                    sendResetCode()
                }) {
                    Text("Send Reset Code")
                        .font(.custom("Poppins", size: 16).weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(red: 0, green: 0.22, blue: 0.40))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Reset Password"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }

                Spacer()
            }
        }
        .background(
            NavigationLink(destination: VerifyCodeView(email: email, verificationCode: verificationCode), isActive: $isNavigatingToVerify) {
                EmptyView()
            }
        )
    }

    private func sendResetCode() {
        guard !email.isEmpty else {
            alertMessage = "Please enter your email address."
            showAlert = true
            return
        }

        let code = String(Int.random(in: 100000...999999))
        verificationCode = code

        let db = Firestore.firestore()
        let expiresAt = Date().addingTimeInterval(15 * 60) // 15 minutes validity
        db.collection("password_reset_codes").document(email).setData([
            "email": email,
            "code": code,
            "expiresAt": Timestamp(date: expiresAt)
        ]) { error in
            if let error = error {
                alertMessage = "Failed to send reset code: \(error.localizedDescription)"
            } else {
                alertMessage = "Reset code sent to \(email)"
                isNavigatingToVerify = true
            }
            showAlert = true
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ForgotPasswordView()
        }
        .previewDevice("iPhone 15 Pro")
    }
}
