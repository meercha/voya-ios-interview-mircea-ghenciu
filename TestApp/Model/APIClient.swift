//
//  APIClient.swift
//  TestApp
//

import Foundation

final class APIClient {
    private let baseURL = URL(string: "https://rickandmortyapi.com/api")!
    private var charactersEndpointURL: URL {
        return baseURL.appendingPathComponent("character")
    }

    /// Retrieves a list of characters from https://rickandmortyapi.com/api/character
    func fetchCharacters(completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        let task = URLSession.testApp.dataTask(with: charactersEndpointURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let data else { return }
                let decoder = JSONDecoder()
                let characters = try? decoder.decode(CharacterResponse.self, from: data)
                completion(.success(characters ?? .init(info: .init(count: 0, pages: 0, next: nil, prev: nil), results: [])))
            }
        }
        task.resume()
    }
    
    func fetchCharacters() async throws -> CharacterResponse {
        // TODO: -
        return .init(info: .init(count: 0, pages: 0, next: nil, prev: nil), results: [])
    }
}

enum APIClientError: Error {
    case invalidResponse
}
