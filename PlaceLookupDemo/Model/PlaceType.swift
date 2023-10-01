//
//  PlaceType.swift
//  PlaceLookupDemo
//
//  Created by Steven Yung on 9/30/23.
//

import Foundation

enum PlaceType: String, CaseIterable, Identifiable {
    case any, restaurant, cafe, coffee
    var id: Self { self }
}
