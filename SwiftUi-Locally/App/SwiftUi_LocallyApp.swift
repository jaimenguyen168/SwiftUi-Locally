//
//  SwiftUi_LocallyApp.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/7/24.
//

import SwiftUI

@main
struct SwiftUi_LocallyApp: App {
    
    @State private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                ContentView()
            } else {
                LocationDeniedView()
            }
        }
        .environment(locationManager)
    }
}
