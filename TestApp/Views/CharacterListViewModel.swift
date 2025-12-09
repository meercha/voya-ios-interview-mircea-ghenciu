//
//  CharacterListViewModel.swift
//  TestApp
//

import Foundation

@Observable
final class CharacterListViewModel {
    private let apiClient: APIClient
    var characters: [Character] = []
    var isLoading: Bool = false
    private(set) var error: APIClientError?

    init(characters: [Character] = [], apiClient: APIClient = APIClient()) {
        self.characters = characters
        self.apiClient = apiClient
    }

    func fetchCharacters() async {
        isLoading = true

        do {
            characters = try await apiClient.fetchCharacters().results
        } catch {
            self.error = error
        }

        isLoading = false
    }
}
