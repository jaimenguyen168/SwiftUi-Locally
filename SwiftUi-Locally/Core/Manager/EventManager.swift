//
//  EventViewModel.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/8/24.
//

import SwiftUI
import SwiftData

@MainActor
@Observable
class EventManager {
    var events: [Event] = []
    
    var bookmarkedEvents: [Event] = []
    
    init() {
        Task { await loadEvents() }
    }
    
    func loadEvents() async {
        events = Event.events
        bookmarkedEvents = events.filter { $0.isBookmarked }
    }
    
    func toggleBookmark(for event: Event) {
        guard let index = events.firstIndex(where: { $0.title == event.title }) else { return }
        
        events[index].isBookmarked.toggle()
        
        if events[index].isBookmarked && !bookmarkedEvents.contains(where: { $0.title == event.title }) {
            bookmarkedEvents.append(events[index])
        } else {
            bookmarkedEvents.removeAll { $0.title == event.title }
        }
    }
    
    func filterEvents(by category: Category) {
        if category == .none {
            self.events = Event.events
        } else {
            self.events = Event.events.filter({
                $0.category == category
            })
        }
    }
}
