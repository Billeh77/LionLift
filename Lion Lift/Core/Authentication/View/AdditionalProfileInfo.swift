//
//  AdditionalProfileInfo.swift
//  Lion Lift
//
//  Created by Chase Preston on 12/9/24.
//

import SwiftUI

struct AdditionalProfileInfoView: View {
    @State private var schoolAndYear: String = ""
    @State private var bio: String = ""
    @State private var venmo: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ZStack {
            Color(red: 0.61, green: 0.80, blue: 0.92)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Complete Your Profile")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    TextField("School and Year (e.g., Columbia College 2025)", text: $schoolAndYear)
                        .modifier(TextFieldModifier())
                    
                    TextEditor(text: $bio)
                        .modifier(TextFieldModifier())
                        .frame(height: 100)
                        .cornerRadius(10)
                        .placeholder(when: bio.isEmpty) {
                            Text("Tell us a bit about yourself (optional)")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 4)
                        }
                    
                    TextField("Venmo Username (optional)", text: $venmo)
                        .modifier(TextFieldModifier())
                }
                .padding(.horizontal)
                
                Button {
                    updateProfileInfo()
                } label: {
                    Text("Continue")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(width: 360, height: 44)
                        .background(.white)
                        .cornerRadius(8)
                        .padding(.vertical)
                        .padding(.top)
                }
                
                Spacer()
                Spacer()
            }
        }
    }
    
    private func updateProfileInfo() {
        // Update the user's profile with additional information
        viewModel.updateAdditionalProfileInfo(
            schoolAndYear: schoolAndYear,
            bio: bio.isEmpty ? nil : bio,
            venmo: venmo.isEmpty ? nil : venmo
        )
    }
}

// Custom modifier to help with TextEditor placeholder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder then: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                then()
            }
            self
        }
    }
}

#Preview {
    AdditionalProfileInfoView()
}
