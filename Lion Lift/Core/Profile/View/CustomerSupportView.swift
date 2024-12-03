import SwiftUI

struct CustomerSupportView: View {
    @State private var message: String = ""
    @State private var isSubmitted: Bool = false
    @State private var validationMessage: String? = nil
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("If you have any issues or feedback, please fill out the form below.")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                    
                    TextEditor(text: $message)
                        .frame(height: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            .navigationTitle("Customer Support")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") {
                        handleSubmit()
                    }
                }
            }
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
                        message: Text("Your feedback has been successfully submitted."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    
    private func handleSubmit() {
        if message.isEmpty {
            validationMessage = "Please enter a message."
        } else {
            validationMessage = nil
            clearForm()
        }
        isSubmitted = true
    }
    
    private func clearForm() {
        message = ""
    }
}

#Preview {
    CustomerSupportView()
}
