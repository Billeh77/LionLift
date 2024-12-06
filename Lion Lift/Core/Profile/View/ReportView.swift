// ReportView.swift
import SwiftUI
import Firebase
import FirebaseAuth // Added

struct ReportView: View {
    @State private var users: [User] = []
    @State private var selectedUser: User?
    @State private var reportReason: String = ""
    @State private var isSubmitted: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            // User Selection Picker
            Picker("Select User", selection: $selectedUser) {
                ForEach(users) { user in
                    Text(user.fullname).tag(user as User?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            // Reason for Reporting Input Field
            TextField("Reason for reporting", text: $reportReason)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal, 20)

            // Report Button
            Button("Report User") {
                submitReport()
            }
            .disabled(selectedUser == nil || reportReason.isEmpty)
            .padding()
            .alert(isPresented: $isSubmitted) {
                if let errorMessage = errorMessage {
                    return Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                } else {
                    return Alert(title: Text("Success"), message: Text("User reported successfully!"), dismissButton: .default(Text("OK")))
                }
            }

            Spacer()
        }
        .onAppear {
            fetchUsers()
        }
    }

    func submitReport() {
        guard let user = selectedUser else { return }

        Report.submitReport(reportedUserId: user.uid, reason: reportReason) { result in
            switch result {
            case .success():
                errorMessage = nil
                isSubmitted = true
            case .failure(let error):
                errorMessage = error.localizedDescription
                isSubmitted = true
            }
        }
    }

    func fetchUsers() {
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
            } else {
                users = snapshot?.documents.compactMap { document -> User? in
                    try? document.data(as: User.self)
                } ?? []
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
