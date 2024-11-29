// File: ContentView.swift Project: LocationAndPlaceLookup
// Created by: Prof. John Gallaugher on 11/27/24
// YouTube.com/profgallaugher  -  threads.net/john.gallaugher

import SwiftUI

struct ContentView: View {
    @State var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Text("\(locationManager.location?.coordinate.latitude ?? 0.0),\(locationManager.location?.coordinate.longitude ?? 0.0)")
            let _ = print("\(locationManager.location?.coordinate.latitude ?? 0.0),\(locationManager.location?.coordinate.longitude ?? 0.0)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
