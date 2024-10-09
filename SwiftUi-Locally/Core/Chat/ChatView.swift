//
//  ChatView.swift
//  SwiftUi-Messenger
//
//  Created by Dat Nguyen on 6/9/24.
//

import SwiftUI

struct ChatView: View {
    
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                // header
                VStack {
                    VStack(spacing: 2) {
                        Text("This event")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
                
                // messages
                ForEach(0..<15) { message in
                    ChatMessageCell(isFromCurrentUser: Bool.random())
                }
            }
            
            // message input
            Spacer()
            
            ZStack(alignment: .trailing) {
                TextField("Message...", text: $messageText, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 56)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(.rect(cornerRadius: 20))
                    .font(.subheadline)
                
                Button {
                    print("DEBUG: Send message")
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                        .foregroundStyle(.indigo)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    ChatView()
}
