import SwiftUI

struct CustomerSupportView: View {
    @State private var selectedTab: Tab = .faq

    enum Tab {
        case faq, contact
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack {
                    // Header
                    VStack {
                        Text("Customer Support")
                            .font(Font.custom("Montserrat", size: 24).weight(.semibold))
                            .foregroundColor(Color(red: 0, green: 0.22, blue: 0.40))

                        // Tabs
                        HStack(spacing: 158) {
                            TabButton(title: "FAQ", isSelected: selectedTab == .faq) {
                                selectedTab = .faq
                            }
                            TabButton(title: "Contact Us", isSelected: selectedTab == .contact) {
                                selectedTab = .contact
                            }
                        }
                        .padding(.top, 20)
                    }

                    Divider()
                        .frame(width: 369, height: 2)
                        .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .padding(.top, 10)

                    // Tab Content
                    if selectedTab == .faq {
                        FAQContentView()
                    } else {
                        ContactUsContentView()
                    }

                    Spacer()
                }
            }
        }
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Font.custom("Montserrat", size: 16).weight(.semibold))
                .foregroundColor(isSelected ? Color(red: 0, green: 0.22, blue: 0.40) : Color(red: 0.92, green: 0.91, blue: 0.91))
        }
    }
}

struct FAQContentView: View {
    @State private var searchText: String = ""
    @State private var expandedQuestion: Int? = nil

    let faqs = [
        (question: "How do I Find the Rider?", answer: "You can find the rider by checking your app for their live location."),
        (question: "How do I Contact Customer Service?", answer: "You can contact customer service through the app or by calling the support hotline."),
        (question: "How to Reset My Password?", answer: "Go to the login page and click on 'Forgot Password' to reset your password.")
    ]

    var filteredFAQs: [(question: String, answer: String)] {
        searchText.isEmpty ? faqs : faqs.filter { $0.question.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        VStack(spacing: 20) {
            // Search Bar
            TextField("Search FAQs", text: $searchText)
                .padding(10)
                .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                .cornerRadius(8)
                .padding(.horizontal, 20)

            // FAQ Items
            ScrollView {
                ForEach(filteredFAQs.indices, id: \.self) { index in
                    let faq = filteredFAQs[index]
                    FAQItemView(
                        question: faq.question,
                        answer: faq.answer,
                        isExpanded: expandedQuestion == index,
                        toggleExpand: {
                            withAnimation {
                                expandedQuestion = (expandedQuestion == index ? nil : index)
                            }
                        }
                    )
                }
            }
            .padding(.top, 10)
        }
        .padding(.top, 20)
    }
}

struct FAQItemView: View {
    let question: String
    let answer: String
    let isExpanded: Bool
    let toggleExpand: () -> Void

    var body: some View {
        VStack {
            HStack {
                Text(question)
                    .font(Font.custom("Montserrat", size: 16).weight(.semibold))
                    .foregroundColor(.black)
                Spacer()
                Button(action: toggleExpand) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(red: 0.61, green: 0.80, blue: 0.92))
            .cornerRadius(23)

            if isExpanded {
                Text(answer)
                    .font(Font.custom("Montserrat", size: 14))
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .padding(.horizontal, 20)
    }
}

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
            // Email Us
            NavigationLink(value: ContactDestination.emailUs) {
                ContactButton(title: "E-mail us")
            }

            // Call Us
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

            // Report the User
            NavigationLink(value: ContactDestination.reportUser) {
                ContactButton(title: "Report the User")
            }
        }
        .navigationDestination(for: ContactDestination.self) { destination in
            switch destination {
            case .emailUs:
                EmailUs()
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

struct EmailUs: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var message: String = ""
    @State private var isSubmitted: Bool = false
    @State private var validationMessage: String? = nil

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                ZStack {
                    HStack {

                        Spacer()
                        Text("Contact Us")
                            .font(Font.custom("Montserrat", size: 24).weight(.semibold))
                            .foregroundColor(Color(red: 0, green: 0.22, blue: 0.40))
                        Spacer()
                        Image(systemName: "chevron.left")
                            .foregroundColor(.clear)
                    }
                    .padding()
                }

                Divider()
                    .frame(height: 2)
                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))


                VStack(alignment: .leading, spacing: 20) {
                    Text("If you have any issues or feedback, please fill out the form below.")
                        .font(.callout)
                        .foregroundColor(.secondary)

                    TextEditor(text: $message)
                        .frame(height: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.bottom, 20)

                    Button(action: {
                        handleSubmit()
                    }) {
                        Text("Submit")
                            .font(Font.custom("Montserrat", size: 16).weight(.semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.61, green: 0.80, blue: 0.92))
                            .cornerRadius(10)
                    }
                }
                .padding()

                Spacer()
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

struct ReportView: View {
    var body: some View {
        Text("Report the User Page")
            .font(Font.custom("Montserrat", size: 24).weight(.semibold))
    }
}

struct CustomerSupportView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerSupportView()
    }
}
