import SwiftUI

struct VerifyCodeView: View {
    @State private var verificationCode: String = "123456" // Simulated code
    @State private var enteredCode: String = ""
    @State private var showMessage: String? = nil

    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.61, green: 0.80, blue: 0.92)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Header Text
                Text("Verify Code")
                    .font(.custom("Poppins", size: 24).weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.top, 50)

                // Code Verification Section
                Text("Enter the 6-digit code we sent to your email")
                    .font(.custom("Poppins", size: 16))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                HStack(spacing: 10) {
                    ForEach(0..<6) { index in
                        TextField("", text: Binding(
                            get: {
                                guard enteredCode.count > index else { return "" }
                                return String(enteredCode[enteredCode.index(enteredCode.startIndex, offsetBy: index)])
                            },
                            set: { newValue in
                                if newValue.count <= 1 {
                                    var code = enteredCode
                                    let stringIndex = code.index(code.startIndex, offsetBy: index)
                                    if index < code.count {
                                        code.replaceSubrange(stringIndex...stringIndex, with: newValue)
                                    } else {
                                        code.append(newValue)
                                    }
                                    enteredCode = String(code.prefix(6))
                                }
                            }
                        ))
                        .frame(width: 40, height: 50)
                        .background(Color.white)
                        .cornerRadius(5)
                        .font(.custom("Roboto", size: 28).weight(.bold))
                        .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                if let message = showMessage {
                    Text(message)
                        .font(.custom("Poppins", size: 14))
                        .foregroundColor(message == "Code verified successfully!" ? .green : .red)
                        .padding(.top, 10)
                }

                // Verify Button
                Button(action: {
                    handleVerifyCode()
                }) {
                    Text("Verify")
                        .font(.custom("Poppins", size: 16).weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(red: 0, green: 0.22, blue: 0.40))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .top)
            .padding(.top, 20)
        }
    }

    func handleVerifyCode() {
        if enteredCode == verificationCode {
            showMessage = "Code verified successfully!"
        } else {
            showMessage = "Invalid code. Please try again."
        }
    }
}

struct VerifyCodeView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyCodeView()
            .previewDevice("iPhone 15 Pro")
    }
}
