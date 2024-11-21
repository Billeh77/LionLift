import SwiftUI

struct CustomerSupportView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var isSubmitted: Bool = false
    @State private var validationMessage: String? = nil
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Customer Support")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .center)

                Form {
                    Text("If you have any issues or feedback, please fill out the form below.")
                    
                    Section(header: Text("Your Information")) {
                        TextField("Name", text: $name)
                            .textContentType(.name)
                            .autocapitalization(.words)
                        
                        TextField("Email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                    }
                    
                    Section(header: Text("Message")) {
                        TextEditor(text: $message)
                            .frame(height: 150)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                .scrollContentBackground(.hidden)
                
                Button(action: handleSubmit) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 16)
                .alert(isPresented: $isSubmitted) {
                    if let validationMessage = validationMessage {
                        return Alert(
                            title: Text("Validation Failed"),
                            message: Text(validationMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    } else {
                        return Alert(
                            title: Text("Thank You!"),
                            message: Text("Your message has been submitted. Our team will get back to you soon."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func handleSubmit() {
        if name.isEmpty {
            validationMessage = "Please enter your name."
            isSubmitted = true
        } else if !isValidEmail(email) {
            validationMessage = "Please enter a valid email address."
            isSubmitted = true
        } else if message.isEmpty {
            validationMessage = "Please enter a message."
            isSubmitted = true
        } else {
            validationMessage = nil
            isSubmitted = true
            clearForm()
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func clearForm() {
        name = ""
        email = ""
        message = ""
    }
}

#Preview {
    CustomerSupportView()
}
