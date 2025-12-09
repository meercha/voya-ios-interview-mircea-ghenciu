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
    func fetchCharacters() async throws(APIClientError) -> CharacterResponse {
        do {
            var request = URLRequest(url: charactersEndpointURL)
            request.httpMethod = "GET"
            
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                throw APIClientError.invalidResponse
            }

            return try JSONDecoder().decode(CharacterResponse.self, from: data)
        } catch _ as DecodingError {
            throw APIClientError.decodingError
        } catch _ as URLError {
            throw APIClientError.urlError
        } catch {
            throw APIClientError.otherError(error)
        }
    }
}

enum APIClientError: Error {
    case invalidResponse
    case decodingError
    case urlError
    case otherError(Error)
}
