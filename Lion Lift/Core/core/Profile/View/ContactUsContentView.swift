//// ContactUsContentView.swift
//import SwiftUI
//import Firebase
//import FirebaseAuth // Added
//
//struct ContactUsContentView: View {
//    @State private var showCallAlert = false
//    @State private var selectedDestination: ContactDestination? = nil
//
//    enum ContactDestination: Hashable {
//        case emailUs
//        case reportUser
//        case chatbot
//    }
//
//    var body: some View {
//        VStack(spacing: 30) {
//            // E-mail us Button
//            NavigationLink(value: ContactDestination.emailUs) {
//                ContactButton(title: "E-mail us")
//            }
//            // Report the User Button
//            NavigationLink(value: ContactDestination.reportUser) {
//                ContactButton(title: "Report the User")
//            }
//            
//            NavigationLink(value: ContactDestination.chatbot) { // Added NavigationLink for Chatbot
//                ContactButton(title: "Chat with Chatbot") // Button for Chatbot
//            }
//            
//        }
//        .navigationDestination(for: ContactDestination.self) { destination in
//            switch destination {
//            case .emailUs:
//                EmailUsView()
//            case .reportUser:
//                ReportView()
//            case .chatbot: // Handle navigation to the ChatbotView
//                ChatbotView()
//            }
//        }
//    }
//
//
//}
//
//struct ContactButton: View {
//    let title: String
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .frame(width: 353, height: 71)
//                .foregroundColor(.clear)
//                .background(Color(red: 0.61, green: 0.80, blue: 0.92))
//                .cornerRadius(21)
//            Text(title)
//                .font(Font.custom("Montserrat", size: 16).weight(.semibold))
//                .foregroundColor(.black)
//        }
//    }
//}
//
//struct ContactUsContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactUsContentView()
//    }
//}
