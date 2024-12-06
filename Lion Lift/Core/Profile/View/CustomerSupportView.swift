// CustomerSupportView.swift
import SwiftUI

struct CustomerSupportView: View {
    @State private var selectedTab: Tab = .faq
    @Environment(\.dismiss) var dismiss // NavigationStack back button

    enum Tab {
        case faq, contact
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack {
                    // Tab Header
                    VStack {
                        Text("Customer Support")
                            .font(Font.custom("Montserrat", size: 24).weight(.semibold))
                            .foregroundColor(Color(red: 0, green: 0.22, blue: 0.40))

                        // Tab Buttons
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
            .navigationTitle("Customer Support")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss() // Go back to previous screen
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
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

struct CustomerSupportView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerSupportView()
    }
}
