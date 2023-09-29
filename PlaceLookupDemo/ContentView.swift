//
//  ContentView.swift
//  PlaceLookupDemo
//
//  Created by Steven Yung on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack (alignment: .leading){
            Image(systemName: "globe")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.tint)
            Spacer()
            Text("Location:\n lat: \(locationManager.location?.coordinate.latitude ?? 0.0)\n long: \(locationManager.location?.coordinate.longitude ?? 0.0)")
                .font(.title)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
