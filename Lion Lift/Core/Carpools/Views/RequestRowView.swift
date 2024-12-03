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
    let user: User
    let flight: Flight
    var body: some View {
        VStack {
            
            HStack {
                Text("hey I am  thinking about leaving columbia at around 4:30 to head to jfk, are you down to carpool?")
                    .padding(12)
                    .background(Color.blue)
                    .font(.system(size: 15))
                    .clipShape(BubbleShape(myMessage: false))
                    .foregroundColor(.white)
                    .padding(.leading, 60)
                
                Spacer()
            }
            
            HStack {
                if let profileImageUrl = user.profileImageUrl {
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
                    Text(user.fullname)
                        .font(.footnote).bold()
                        .foregroundColor(.black)
                    Text(flight.departureAirport + ", " + flight.departureTerminal)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Text(formatTimestamp(flight.departureDateAndTime))
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                Button {
                    // Ignore request logic here
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
                    // Accept request logic here
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

#Preview {
    RequestRowView(user: User.dummyUser, flight: Flight.dummyFlight)
}
