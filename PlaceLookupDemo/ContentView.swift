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

                // map to current location or Apple HQ if location info does not exist
                let cameraPosition = (locationManager.location == nil) ? MapCameraPosition.region(locationManager.appleHQReg) :
                    MapCameraPosition.region(locationManager.region)
                
                Map(initialPosition: cameraPosition) {
                    
                    /*Marker("", systemImage: "circle.circle.fill", coordinate: locationManager.location?.coordinate ?? locationManager.appleHQLoc)
                        .tint(.blue)*/
                    Annotation("", coordinate: locationManager.location?.coordinate ?? locationManager.appleHQLoc) {
                        Image(systemName: "circle.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                    if returnPlace.latitude != 180.0 {
                        Marker(returnPlace.name, coordinate: CLLocationCoordinate2D(latitude: returnPlace.latitude, longitude: returnPlace.longitude))
                    }
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
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
