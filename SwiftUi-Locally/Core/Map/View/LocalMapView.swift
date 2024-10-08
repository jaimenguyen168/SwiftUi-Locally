//
//  LocalMapView.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/7/24.
//

import SwiftUI
import MapKit
import SwiftData

struct LocalMapView: View {
    
    @Environment(LocationManager.self) var locationManager
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var eventList: [Event] = Event.events
    
    @State private var showFilterMenu = false
    
    @State private var selectedEvent: Event?
    @State private var isFullSheet = false
    @State private var selectedDetent: PresentationDetent = .fraction(0.35)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $cameraPosition) {
                Marker("My Location", coordinate: locationManager.userLocation?.coordinate ?? .empy)
                
                ForEach(eventList) { event in
                    Annotation(event.name, coordinate: event.coordinate) {
                        
                        LocalMarker(
                            event: event,
                            isSelected: selectedEvent == event
                        )
                        .onTapGesture {
                            selectedEvent = event
                            withAnimation {
                                let region = MKCoordinateRegion(
                                    center: event.coordinate,
                                    span: MKCoordinateSpan(
                                        latitudeDelta: 0.1,
                                        longitudeDelta: 0.1
                                    )
                                )
                                cameraPosition = .region(region)
                            }
                        }
                    }
                }
            }
            .onAppear {
                updateCameraPosition()
            }
            .mapControls {
                MapUserLocationButton()
            }
            .sheet(item: $selectedEvent) { event in
                eventSheet(for: event)
                    .presentationDetents(
                        [.fraction(0.35), .fraction(0.7)],
                        selection: $selectedDetent
                    )
                    .onTapGesture {
                        withAnimation {
                            isFullSheet.toggle()
                            selectedDetent = (selectedDetent == .fraction(0.35)) ? .fraction(0.7) : .fraction(0.35)
                        }
                    }
            }
            
            filterMenu
        }
    }
    
    func updateCameraPosition() {
        if let userLocation = locationManager.userLocation {
            let userRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.1,
                    longitudeDelta: 0.1
                )
            )
            withAnimation {
                cameraPosition = .region(userRegion)
            }
        }
    }
}

#Preview {
    LocalMapView()
        .environment(LocationManager())
}

private extension LocalMapView {
    func eventSheet(for event: Event) -> some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                VStack {
                    VStack {
                        if let image = event.image {
                            Image(image)
                                .resizable()
                        } else {
                            Image(systemName: "photo")
                                .resizable()
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
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4) // Adding shadow for elevation effect
            )
            .padding()
            
            if isFullSheet {
                ChatView()
                    .transition(.move(edge: .bottom))
            } else {
                Button {
                    selectedEvent = nil
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.system(size: 32))
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.indigo)
                .clipShape(Capsule())
                .padding(.horizontal)
                .transition(.identity)
//                .animation(nil, value: isFullSheet)
            }
        }
    }
    
    var filterMenu: some View {
        HStack {
            Spacer()
            
            VStack {
                if showFilterMenu {
                    VStack(spacing: 0) {
                        ForEach(Category.allCases) { category in
                            Button {
                                eventList = Event.events.filter({
                                    $0.category == category
                                })
                                withAnimation {
                                    showFilterMenu = false
                                }
                            } label: {
                                Image(systemName: category.icon)
                            }
                            .padding(.top, 12)
                            .transition(.move(edge: .bottom))
                            .animation(.smooth, value: showFilterMenu)
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        showFilterMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
                .padding(12)
                .clipShape(Circle())
            }
            .background(.indigo)
            .clipShape(Capsule())
        }
        .font(.system(size: 16, weight: .bold))
        .padding(.trailing, 16)
        .padding(.bottom, 16)
        .tint(.white)
    }
}


extension CLLocationCoordinate2D {
    static let newYork = CLLocationCoordinate2D(
        latitude: 40.7128,
        longitude: -74.0060
    )
    
    static let statue = CLLocationCoordinate2D(
        latitude: 40.6892,
        longitude: -74.0445
    )
    
    static let empy = CLLocationCoordinate2D(
        latitude: 40.7484,
        longitude: -73.9857
    )
}

struct MarkerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Create a circular top
        path.addArc(center: CGPoint(x: rect.midX, y: rect.width / 2),
                    radius: rect.width / 2,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        
        // Create smooth curved sides leading to the pointy bottom
        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.height),
            control1: CGPoint(x: rect.midX + rect.width / 2, y: rect.width * 0.9),
            control2: CGPoint(x: rect.midX + rect.width * 0.1, y: rect.height * 0.75)
        )
        
        path.addCurve(
            to: CGPoint(x: rect.midX - rect.width / 2, y: rect.width / 2),
            control1: CGPoint(x: rect.midX - rect.width * 0.1, y: rect.height * 0.75),
            control2: CGPoint(x: rect.midX - rect.width / 2, y: rect.width * 0.9)
        )
        
        path.closeSubpath()
        return path
    }
}

struct LocalMarker: View {
    let event: Event
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            MarkerShape()
                .fill(.indigo)
                .frame(width: 30, height: 40)

            if let image = event.image {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .offset(y: -5) // Adjust for centering
            } else {
                Image(systemName: event.category.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)
                    .offset(y: -5) // Adjust for centering
            }
        }
        .scaleEffect(isSelected ? 1.5 : 1)
        .animation(.spring(), value: isSelected)
    }
}

