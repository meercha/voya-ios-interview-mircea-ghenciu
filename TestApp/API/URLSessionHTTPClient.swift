//
//  URLSessionHTTPClient.swift
//  TestApp
//
//  Created by Mircea Ghenciu on 09.12.2025.
//


import Foundation

class URLSessionHTTPClient: HTTPClient {
	private let baseURL: URL
	private let session: URLSessionProtocol
	
	init(baseURL: URL, session: URLSessionProtocol) {
		self.baseURL = baseURL
		self.session = session
	}
	
	func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
		guard var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path),
																				 resolvingAgainstBaseURL: true)
		else { throw APIClientError.urlError }
		
		components.queryItems = endpoint.queryParameters
		
		guard let url = components.url else {
			throw APIClientError.urlError
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.stringValue
		
		let data: Data
		let response: URLResponse
		
		do {
			(data, response) = try await session.data(for: request)
		} catch {
			throw APIClientError.invalidResponse
		}
		
		guard let httpResponse = response as? HTTPURLResponse else {
			throw APIClientError.invalidResponse
		}
		
		guard (200..<299).contains(httpResponse.statusCode) else {
			throw APIClientError.invalidResponse
		}
		
		do {
			return try JSONDecoder().decode(T.self, from: data)
		} catch {
			throw APIClientError.decodingError
		}
	}
}
