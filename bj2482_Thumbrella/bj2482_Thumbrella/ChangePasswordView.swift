import SwiftUI

struct ChangePasswordView: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var passwordChanged: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Current Password")) {
                SecureField("Enter current password", text: $currentPassword)
            }
            
            Section(header: Text("New Password")) {
                SecureField("Enter new password", text: $newPassword)
            }
            
            Section(header: Text("Confirm New Password")) {
                SecureField("Confirm new password", text: $confirmPassword)
            }
            
            Button("Change Password") {
                if newPassword == confirmPassword {
                    // Logic to handle password change
                    passwordChanged = true
                    // Ideally, you would add additional logic to verify current password
                    // and store the new password securely.
                } else {
                    // Handle password mismatch
                    passwordChanged = false
                }
            }
            .alert(isPresented: $passwordChanged) {
                Alert(title: Text("Success"), message: Text("Password changed successfully!"), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Change Password")
    }
}
