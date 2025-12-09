//
//  HTTPClient.swift
//  TestApp
//
//  Created by Mircea Ghenciu on 09.12.2025.
//


protocol HTTPClient {
	func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T
}
