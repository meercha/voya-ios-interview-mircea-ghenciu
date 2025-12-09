//
//  CharacterListViewModel.swift
//  TestApp
//

import Foundation

enum ViewState: Equatable {
	case idle
	case loading
	case loadingMore
	case error(String)
	case empty
}

@MainActor
@Observable
final class CharacterListViewModel {
	
	// MARK: - Properties
	private let httpClient: HTTPClient
	
	var state: ViewState = .idle
	var characters: [Character] = []
	
	private var page: Int = 1
	private var canLoadMore: Bool = true
	
	init(httpClient: HTTPClient) {
		self.httpClient = httpClient
	}
	
	func fetchCharacters() async {
		guard state != .loading && state != .loadingMore && canLoadMore else { return }
		
		state = characters.isEmpty ? .loading : .loadingMore
		
		do {
			let response: CharacterResponse = try await httpClient.sendRequest(endpoint: .characters(page: page))
			
			if response.results.isEmpty {
				canLoadMore = false
				state = .empty
			} else {
				self.characters.append(contentsOf: response.results)
				self.page += 1
			}
			
			state = .idle
		} catch {
			state = .error(error.localizedDescription)
		}
	}
}
