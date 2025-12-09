//
//  CharacterResponse.swift
//  TestApp
//

import Foundation

struct CharacterResponse: Codable {
    let info: PageInfo
    let results: [Character]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let species: String
    let image: String
    let type: String
    let origin: LocationReference
    let location: LocationReference
}

extension Character: Equatable {
	static func == (lhs: Character, rhs: Character) -> Bool {
		lhs.id == rhs.id
	}
}

struct LocationReference: Codable {
    let name: String
    let url: String
}
