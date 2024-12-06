// ContactUsContentView.swift
import SwiftUI
import Firebase
import FirebaseAuth // Added

struct ContactUsContentView: View {
    @State private var showCallAlert = false
    @State private var selectedDestination: ContactDestination? = nil
    let phoneNumber = "111-111-1111"

    enum ContactDestination: Hashable {
        case emailUs
        case reportUser
    }

    var body: some View {
        VStack(spacing: 30) {
            // E-mail us Button
            NavigationLink(value: ContactDestination.emailUs) {
                ContactButton(title: "E-mail us")
            }

            // Call Us Button (Commented out)
            /*
            Button(action: {
                showCallAlert = true
            }) {
                ContactButton(title: "Call us")
            }
            .alert(isPresented: $showCallAlert) {
                Alert(
                    title: Text("Call"),
                    message: Text("Do you want to call \(phoneNumber)?"),
                    primaryButton: .default(Text("Yes"), action: {
                        callPhoneNumber(phoneNumber)
                    }),
                    secondaryButton: .cancel()
                )
            }
            */

            // Report the User Button
            NavigationLink(value: ContactDestination.reportUser) {
                ContactButton(title: "Report the User")
            }
        }
        .navigationDestination(for: ContactDestination.self) { destination in
            switch destination {
            case .emailUs:
                EmailUsView()
            case .reportUser:
                ReportView()
            }
        }
    }

    func callPhoneNumber(_ number: String) {
        guard let url = URL(string: "tel://\(number)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

struct ContactButton: View {
    let title: String

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 353, height: 71)
                .foregroundColor(.clear)
                .background(Color(red: 0.61, green: 0.80, blue: 0.92))
                .cornerRadius(21)
            Text(title)
                .font(Font.custom("Montserrat", size: 16).weight(.semibold))
                .foregroundColor(.black)
        }
    }
}

struct ContactUsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsContentView()
    }
}
