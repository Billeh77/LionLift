//
//  EmailUs.swift
//  Lion Lift
//
//  Created by Chloe Lee on 12/5/24.
//

import SwiftUI

struct EmailUs: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var message: String = ""
    @State private var isSubmitted: Bool = false
    @State private var validationMessage: String? = nil

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                // 헤더 영역
                ZStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(red: 0, green: 0.22, blue: 0.40))
                        }
                        Spacer()
                        Text("Contact Us")
                            .font(Font.custom("Montserrat", size: 24).weight(.semibold))
                            .foregroundColor(Color(red: 0, green: 0.22, blue: 0.40))
                        Spacer()
                        // 빈 공간으로 균형 맞추기
                        Image(systemName: "chevron.left")
                            .foregroundColor(.clear)
                    }
                    .padding()
                }

                Divider()
                    .frame(height: 2)
                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))

                Spacer()

                // 폼 영역
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

#Preview {
    EmailUs()
}
