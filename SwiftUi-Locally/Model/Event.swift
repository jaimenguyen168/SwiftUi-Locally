//
//  Event.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/8/24.
//


import SwiftData
import MapKit

enum Category: Int, CaseIterable, Identifiable, Codable {
    
    case social, music, event, museum
    
    var icon: String {
        switch self {
        case .social: "hands.clap.fill"
        case .music: "music.quarternote.3"
        case .event: "calendar.badge.plus.fill"
        case .museum: "building.columns.fill"
        }
    }
    
    var id: Int { rawValue }
}

@Model
class Event {
    
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    
    var title: String
    var descriptionText: String?
    var image: String?
    var date: Date
    var startTime: Date
    var endTime: Date
    var category: Category
    
    var attending: Int?
    
    init(name: String, address: String, latitude: Double, longitude: Double, title: String, descriptionText: String? = nil, image: String? = nil, date: Date, startTime: Date, endTime: Date, category: Category, attending: Int? = nil) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.title = title
        self.descriptionText = descriptionText
        self.image = image
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.category = category
        self.attending = attending
    }
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
    
    static func formatDateTime(date: Date, startTime: Date, endTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d, yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        let dateString = dateFormatter.string(from: date)
        let startTimeString = timeFormatter.string(from: startTime)
        let endTimeString = timeFormatter.string(from: endTime)
        
        return "\(dateString) from \(startTimeString) - \(endTimeString)"
    }
    
    static var events: [Event] {
        let calendar = Calendar.current

        // Date components for the event (e.g., October 17, 2024)
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 10
        dateComponents.day = 17

        // Start time: 10 AM
        var startTimeComponents = dateComponents
        startTimeComponents.hour = 10
        startTimeComponents.minute = 0

        // End time: 5 PM
        var endTimeComponents = dateComponents
        endTimeComponents.hour = 17
        endTimeComponents.minute = 0

        // Generate Date objects
        let eventDate = calendar.date(from: dateComponents)!
        let startTime = calendar.date(from: startTimeComponents)!
        let endTime = calendar.date(from: endTimeComponents)!
        
        return [
            .init(
                name: "Arts Museum",
                address: "1876, Fairmount Park, Philadelphia",
                latitude: 39.9656,
                longitude: -75.1810,
                title: "Mozart Exhibition",
                descriptionText: "An exhibition to celebrate the work of the greatest composer of all time.",
                image: "image1",
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .museum,
                attending: 500
            ),
           .init(
                name: "City Hall",
                address: "1400 John F Kennedy Blvd, Philadelphia",
                latitude: 39.9526,
                longitude: -75.1652,
                title: "Public City Council Meeting",
                descriptionText: "A public event where citizens can attend the city council's discussions on community development.",
                image: "image2",
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .social,
                attending: 250
            ),
            .init(
                name: "Tabu Philadelphia",
                address: "254 S 12th, Philadelphia",
                latitude: 39.9445501,
                longitude: -75.1668142,
                title: "Philly Drags Night",
                descriptionText: "",
                image: nil,
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .music,
                attending: 75
            )
        ]
    }
}
