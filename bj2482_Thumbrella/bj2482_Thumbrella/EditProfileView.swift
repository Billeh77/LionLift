import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var newName: String = ""
    @State private var newAge: String = ""
    @State private var newPhone: String = ""
    @State private var newEmail: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Enter new name", text: $newName)
            }
            
            Section(header: Text("Age")) {
                TextField("Enter new age", text: $newAge)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Phone Number")) {
                TextField("Enter new phone number", text: $newPhone)
                    .keyboardType(.phonePad)
            }
            
            Section(header: Text("Email")) {
                TextField("Enter new email", text: $newEmail)
                    .keyboardType(.emailAddress)
            }
            
            Button("Save Changes") {
                // Save the edited information back to the ProfileViewModel
                viewModel.userName = newName
                viewModel.userAge = newAge
                viewModel.userPhone = newPhone
                viewModel.userEmail = newEmail
            }
        }
        .onAppear {
            // Load existing data into the fields
            newName = viewModel.userName
            newAge = viewModel.userAge
            newPhone = viewModel.userPhone
            newEmail = viewModel.userEmail
        }
        .navigationTitle("Edit Profile")
    }
}
