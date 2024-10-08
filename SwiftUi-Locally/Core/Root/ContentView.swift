//
//  ContentView.swift
//  SwiftUi-Locally
//
//  Created by Dat Nguyen on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            MainTabView()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        .environment(LocationManager())
}
