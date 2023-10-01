//
//  LookupExtra.swift
//  PlaceLookupDemo
//
//  Created by Steven Yung on 9/30/23.
//

import SwiftUI
import MapKit

struct LookupExtra: View {
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var placeVM = PlaceViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var placeType : PlaceType = .any
    
    @Binding var returnedPlace: Place
    
    var body: some View {
        NavigationStack {
            Picker("Type", selection: $placeType) {
                ForEach(PlaceType.allCases) { pType in
                    Text(pType.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            List(placeVM.places) {place in
                VStack (alignment: .leading) {
                    Text(place.name)
                        .font(.title2)
                    Text(place.address)
                        .font(.callout)
                }
                .onTapGesture {
                    returnedPlace = place
                    dismiss()
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText)
            .onChange(of: searchText, {
                if !searchText.isEmpty {
                    let newSearchText = placeType == .any ? searchText : "\(placeType.rawValue) \(searchText)"
                    placeVM.search(text: newSearchText, region: locationManager.region)
                } else {
                    placeVM.places = []
                }
            })
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    LookupExtra(returnedPlace: .constant(Place(mapItem: MKMapItem())))
        .environmentObject(LocationManager())
}
