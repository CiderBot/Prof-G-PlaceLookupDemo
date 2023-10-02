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
    @State private var showLookupExtraSheet = false
    @State var returnPlace = Place(mapItem: MKMapItem())
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                Text("Location:\n lat: \(locationManager.location?.coordinate.latitude ?? 0.0)\n long: \(locationManager.location?.coordinate.longitude ?? 0.0)")
                    .font(.title)
                Text("\nReturned Place\nName: \(returnPlace.name)\nAddress:\(returnPlace.address)\nCoords: \(returnPlace.latitude), \(returnPlace.longitude)")
                Spacer()
                let cameraBounds = MapCameraBounds(centerCoordinateBounds: locationManager.region, minimumDistance: 1.0, maximumDistance: 10000.0)
                Map(bounds: cameraBounds, interactionModes: .all) {

                    /*Marker("My Location", coordinate: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417))*/
                }
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        showPlaceLookupSheet.toggle()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                        Text("Lookup Place")
                    })
                    Button(action: {
                        showLookupExtraSheet.toggle()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                        Text("Lookup Extra")
                    })
                }
            }
        }
        .fullScreenCover(isPresented: $showPlaceLookupSheet, content: {
            PlaceLookupView(returnedPlace: $returnPlace)
        })
        .fullScreenCover(isPresented: $showLookupExtraSheet, content: {
            LookupExtra(returnedPlace: $returnPlace)
        })
//        .onAppear {
//            cameraPosition = MapCameraPosition.region(locationManager.region)
//        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
