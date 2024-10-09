//
//  ChatMessageCell.swift
//  SwiftUi-Messenger
//
//  Created by Dat Nguyen on 6/9/24.
//

import SwiftUI

struct ChatMessageCell: View {
    
    let isFromCurrentUser: Bool
    
    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                
                Text("This is a test message from the current user but it's a bit longer.")
                    .font(.subheadline)
                    .padding(12)
                    .background(.indigo)
                    .foregroundStyle(.white)
                    .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: currentUserChatBubbleWidth, alignment: .trailing)
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    CircularProfileImageView(user: User.MockUser, size: .xxSmall)
                    
                    Text("This is a test message from the other user.")
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .foregroundStyle(.black)
                        .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
                        .frame(maxWidth: otherUserChatBubbleWidth, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    ChatMessageCell(isFromCurrentUser: true)
}

private extension ChatMessageCell {
    var currentUserChatBubbleWidth: CGFloat {
        return UIScreen.main.bounds.width / 1.5
    }
    
    var otherUserChatBubbleWidth: CGFloat {
        return UIScreen.main.bounds.width / 1.75
    }
}
