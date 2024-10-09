//
//  MainTabView.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/7/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Group {
                LocalMapView()
                    .tabItem {
                        Label("Local", systemImage: "map")
                    }
                
                BookmarkView()
                    .tabItem {
                        Label("Favorite", systemImage: "bookmark")
                    }

                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .toolbarBackground(.indigo, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    MainTabView()
        .environment(LocationManager())
        .environment(EventManager())
}
