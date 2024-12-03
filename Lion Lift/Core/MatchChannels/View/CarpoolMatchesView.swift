//
//  MatchesView.swift
//  Lion Lift
//
//  Created by Emile Billeh on 03/12/2024.
//

import SwiftUI

struct CarpoolMatchesView: View {
    @State private var showChatView = false
    @State var selectedChannel: Match?
    @ObservedObject var viewModel = MatchesViewModel()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let channel = selectedChannel {
                NavigationLink(
                    destination: ChannelView(channel: channel),
                    isActive: $showChatView,
                    label: { })
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.matches) { channel in
                        MatchCell(viewModel: MatchCellViewModel(channel))
                    }
                    HStack { Spacer() }
                }
            }
        }
    }
    
}


struct ChannelsView_Previews: PreviewProvider {
    static var previews: some View {
        CarpoolMatchesView()
    }
}
