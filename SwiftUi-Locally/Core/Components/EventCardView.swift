//
//  EventCardView.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/8/24.
//

import SwiftUI

struct EventCardView: View {
    
    var event: Event = Event.events[2]
    var isBookmarked: Bool = false
    var onBookmarkTapped: (() -> Void)? = nil
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                VStack {
                    VStack {
                        if let image = event.image {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "photo.badge.exclamationmark")
                                .resizable()
                                .frame(width: 60, height: 50)
                                .foregroundStyle(.secondary)
                                .offset(x: 4, y: 4)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    
                    Text(event.name)
                        .font(.body)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(event.title)
                        .font(.headline)
                        .lineLimit(2)
                    
                    Divider()

                    if let desc = event.descriptionText {
                        Text(desc)
                            .font(.subheadline)
                            .lineLimit(2)
                    }

                    HStack {
                        Image(systemName: "mappin.and.ellipse.circle")
                        
                        Text(event.address)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }

                    HStack {
                        Image(systemName: "person")
                        
                        Text("**\(event.attending ?? 0)** people attending")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
            )
            .padding()
            .overlay(alignment: .topTrailing) {
                Button {
                    onBookmarkTapped?()
                } label: {
                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.title)
                        .foregroundStyle(.indigo)
                }
                .offset(x: -32, y: 6)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 2)
            }
        }
    }
}

#Preview {
    EventCardView()
}
