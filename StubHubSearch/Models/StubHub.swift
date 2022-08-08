//
//  StubHub.swift
//  StubHubSearch
//
//  Created by HT on 07/08/22.
//

import Foundation

struct Events: Decodable {
    let id: Int
    let name: String?
    let venueName: String?
    let city: String?
    let price: Int
    let distanceFromVenue: Double?
    let date: String?
}
struct Children: Decodable {
    let id: Int
    let name: String?
    let children: [Children]?
    let events: [Events]?
}

struct StubHub: Decodable {
    let id: Int
    let name: String
    let events: [Events]?
    let children: [Children]?
}

struct PresentableEvents {
    let artistName: String
    let city: String
    let price: Int
}
