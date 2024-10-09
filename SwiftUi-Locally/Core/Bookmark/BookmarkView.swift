//
//  BookmarkView.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/7/24.
//

import SwiftUI

struct BookmarkView: View {
    
    @Environment(EventManager.self) var eventManager
    
    var body: some View {
        NavigationStack {
            VStack {  
                ScrollView {
                    LazyVStack {
                        ForEach(eventManager.bookmarkedEvents) { event in
                            EventCardView(
                                event: event,
                                isBookmarked: event.isBookmarked,
                                onBookmarkTapped: {
                                    eventManager.toggleBookmark(for: event)
                                }
                            )
                        }
                    }
                }
            }
            .toolbar {
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Bookmarks")
        }
    }
}

#Preview {
    BookmarkView()
        .environment(EventManager())
}
