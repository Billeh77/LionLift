//
//  RequestRowView.swift
//  Carpools
//
//  Created by Emile Billeh on 14/11/2024.
//

import SwiftUI
import Kingfisher
import Firebase

struct RequestRowView: View {
    let request: Request
    var viewModel: RequestRowViewModel
    init(request: Request) {
        self.request = request
        self.viewModel = RequestRowViewModel(request: request)
    }
    var body: some View {
        VStack {
            
            HStack {
                Text(request.message)
                    .padding(12)
                    .background(Color.blue)
                    .font(.system(size: 15))
                    .clipShape(BubbleShape(myMessage: false))
                    .foregroundColor(.white)
                    .padding(.leading, 60)
                
                Spacer()
            }
            
            HStack {
                if let profileImageUrl = request.profileImageUrl {
                    KFImage(URL(string: profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                } else {
                    ZStack {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 65, height: 65)
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.white)
                    }
                }
                
                VStack (alignment: .leading, spacing: 4) {
                    Text(request.fullname)
                        .font(.footnote).bold()
                        .foregroundColor(.black)
                    Text(request.airport)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text(formatTimestamp(request.flightDateAndTime))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Button {
                    viewModel.ignoreRequest()
                } label: {
                    Text("Ignore")
                        .padding(10)
                        .background(.white)
                        .foregroundStyle(.black)
                        .font(.caption)
                        .cornerRadius(5)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                }
                
                Button {
                    viewModel.acceptRequest()
                } label: {
                    Text("Accept")
                        .padding(10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .font(.caption)
                        .cornerRadius(5)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                
            }
            .padding(.horizontal)
        }
    }
    
    private func formatTimestamp(_ timestamp: Timestamp) -> String {
        let date = timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}
