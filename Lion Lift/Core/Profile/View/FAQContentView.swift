// FAQContentView.swift
import SwiftUI

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

            // FAQ Items List
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

struct FAQContentView_Previews: PreviewProvider {
    static var previews: some View {
        FAQContentView()
    }
}
