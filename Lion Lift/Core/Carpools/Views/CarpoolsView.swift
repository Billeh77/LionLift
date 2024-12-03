//
//  ContentView.swift
//  Carpools
//
//  Created by Emile Billeh on 14/11/2024.
//

import SwiftUI

struct CarpoolsView: View {
    @State private var selectedFilter: CarpoolManagerViewModel = .carpools
    @Namespace var animation
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(CarpoolManagerViewModel.allCases, id: \.rawValue) { item in
                        VStack {
                            Text(item.title)
                            //.fontWeight(selectedFilter == item ? .semibold : .regular)
                                .foregroundColor(selectedFilter == item ? .black : .gray)
                            
                            if selectedFilter == item {
                                Capsule()
                                    .frame(height: 3)
                                    .foregroundColor(.blue)
                                    .matchedGeometryEffect(id: "filter", in: animation)
                            } else {
                                Capsule()
                                    .frame(height: 3)
                                    .foregroundColor(.clear )
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.selectedFilter = item
                            }
                        }
                    }
                }
                .padding(.top)
                
                TabView(selection: $selectedFilter) {
                    carpools.tag(CarpoolManagerViewModel.carpools)
                    requests.tag(CarpoolManagerViewModel.requests)
                    matches.tag(CarpoolManagerViewModel.matches)
                }
            }
            .navigationTitle("Carpools")
        }
    }
}

extension CarpoolsView {
    var carpools: some View {
        VStack {
            VStack {
                Text("You have no carpools yet")
                Text("Request to join carpools from your matches")
                Text("Or check your requests")
            }
            .foregroundStyle(.gray)
        }
    }
    
    var requests: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(0..<5, id: \.self) { _ in
                        RequestRowView(user: User.dummyUser, match: Match.dummyMatch)
                            .padding(.vertical)
                    }
                    Spacer()
                }
            }
        }
    }
    
    var matches: some View {
        VStack {
            ForEach(0..<3, id: \.self) { _ in
                MatchRowView(user: User.dummyUser, match: Match.dummyMatch)
            }
            Spacer()
        }
    }
}

#Preview {
    CarpoolsView()
}
