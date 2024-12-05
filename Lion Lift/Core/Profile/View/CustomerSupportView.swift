import SwiftUI
import Firebase
import FirebaseAuth

struct CustomerSupportView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var isSubmitted: Bool = false
    @State private var validationMessage: String? = nil
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .foregroundColor(.black)
                        .imageScale(.large)
                        .padding(.horizontal)
                }
                
                Text("Customer Support")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if let user = viewModel.currentUser {
                    Form {
                        Text("If you have any issues or feedback, please fill out the form below.")
                        
                        Section(header: Text("Your Information")) {
                            TextField("Name", text: $name)
                                .textContentType(.name)
                                .autocapitalization(.words)
                                .onAppear() {
                                    name = user.fullname
                                }
                            
                            TextField("Email", text: $email)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .onAppear() {
                                    email = user.email
                                }
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
                }
                
                Button(action: handleSubmit) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .alert(isPresented: $isSubmitted) {
                    if let validationMessage = validationMessage {
                        return Alert(
                            title: Text("Failed to send messsage"),
                            message: Text(validationMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    } else {
                        return Alert(
                            title: Text("Thank You!"),
                            message: Text("Your message has been submitted. Our team will get back to you soon."),
                            dismissButton: .default(Text("OK"), action: {
                                dismiss() // Dismiss the view when "OK" is tapped
                            })
                        )
                    }
                }
                
                Spacer()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    func pushMessageToDatabase(withEmail email: String, fullName: String, message: String) {
        guard let currentUser = Auth.auth().currentUser else {
            print("DEBUG: No user is logged in.")
            return
        }
        
        let uid = currentUser.uid
        let data = [
            "name": fullName,
            "email": email,
            "message": message,
            "uid": uid,
        ] as [String : Any]
        
        Firestore.firestore().collection("customer support messages")
            .addDocument(data: data) { error in
                if let error = error {
                    print("DEBUG: Failed to save message with error: \(error.localizedDescription)")
                } else {
                    print("DEBUG: Message saved successfully.")
                }
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
            
            pushMessageToDatabase(withEmail: email, fullName: name, message: message)
            
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
