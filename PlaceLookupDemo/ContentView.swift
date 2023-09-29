//
//  ContentView.swift
//  PlaceLookupDemo
//
//  Created by Steven Yung on 9/28/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var showPlaceLookupSheet = false
    @State var returnPlace = Place(mapItem: MKMapItem())
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                Image(systemName: "globe")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.tint)
                Spacer()
                Text("Location:\n lat: \(locationManager.location?.coordinate.latitude ?? 0.0)\n long: \(locationManager.location?.coordinate.longitude ?? 0.0)")
                    .font(.title)
                Text("\nReturned Place\nName: \(returnPlace.name)\nAddress:\(returnPlace.address)\nCoords: \(returnPlace.latitude), \(returnPlace.longitude)")
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showPlaceLookupSheet.toggle()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                        Text("Lookup Place")
                    })
                }
            }
        }
        .fullScreenCover(isPresented: $showPlaceLookupSheet, content: {
            PlaceLookupView(returnedPlace: $returnPlace)
        })
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
