//
//  Event.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/8/24.
//


import SwiftData
import MapKit

enum Category: Int, CaseIterable, Identifiable, Codable {
    
    case social, music, event, museum, none
    
    var icon: String {
        switch self {
        case .social: "hands.clap.fill"
        case .music: "music.quarternote.3"
        case .event: "calendar.badge.plus"
        case .museum: "building.columns.fill"
        case .none: "line.horizontal.3.decrease.circle"
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
    var isBookmarked: Bool = false
    
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
}

extension Event {
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
            ),
            .init(
                name: "Franklin Institute",
                address: "222 N 20th St, Philadelphia",
                latitude: 39.9582,
                longitude: -75.1737,
                title: "Science After Hours",
                descriptionText: "An adult-only evening event featuring cocktails, live science demonstrations, and hands-on experiments.",
                image: "image3",
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .museum,
                attending: 300
            ),
            .init(
                name: "Spruce Street Harbor Park",
                address: "301 S Christopher Columbus Blvd, Philadelphia",
                latitude: 39.9460,
                longitude: -75.1416,
                title: "SummerFest Concert Series",
                descriptionText: "An outdoor concert featuring local bands and food trucks by the river.",
                image: "image4",
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .music,
                attending: 600
            ),
            .init(
                name: "Rittenhouse Square",
                address: "210 W Rittenhouse Square, Philadelphia",
                latitude: 39.9487,
                longitude: -75.1710,
                title: "Outdoor Yoga",
                descriptionText: "Join a relaxing outdoor yoga session in one of Philadelphia's most iconic parks.",
                image: "image5",
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .social,
                attending: 80
            ),
            .init(
                name: "Philadelphia Zoo",
                address: "3400 W Girard Ave, Philadelphia",
                latitude: 39.9740,
                longitude: -75.1955,
                title: "Nighttime Safari",
                descriptionText: "A guided tour of the zoo after hours, with exclusive animal encounters and talks.",
                image: "image6",
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .event,
                attending: 200
            ),
            .init(
                name: "Barnes Foundation",
                address: "2025 Benjamin Franklin Pkwy, Philadelphia",
                latitude: 39.9606,
                longitude: -75.1726,
                title: "Impressionist Art Exhibit",
                descriptionText: "A curated collection featuring works by renowned Impressionist artists.",
                image: nil,
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .museum,
                attending: 350
            ),
            .init(
                name: "The Fillmore",
                address: "29 E Allen St, Philadelphia",
                latitude: 39.9621,
                longitude: -75.1354,
                title: "Indie Rock Night",
                descriptionText: "An evening of live performances from top indie rock bands.",
                image: nil,
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .music,
                attending: 400
            ),
            .init(
                name: "Reading Terminal Market",
                address: "1136 Arch St, Philadelphia",
                latitude: 39.9531,
                longitude: -75.1592,
                title: "Foodie Festival",
                descriptionText: "A celebration of Philadelphia's vibrant food scene with cooking demonstrations, tastings, and local vendors.",
                image: nil,
                date: eventDate,
                startTime: startTime,
                endTime: endTime,
                category: .event,
                attending: 700
            )
        ]
    }
}
