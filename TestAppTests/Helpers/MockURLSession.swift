//
//  MockURLSession.swift
//  TestApp
//
//  Created by Mircea Ghenciu on 09.12.2025.
//


import Foundation

final class MockURLSession: URLSessionProtocol, @unchecked Sendable {
	var data: Data?
	var urlResponse: URLResponse?
	var error: Error?
	var lastRequest: URLRequest? // To spy on what the client sent
	
	func data(for request: URLRequest) async throws -> (Data, URLResponse) {
		lastRequest = request
		
		if let error = error {
			throw error
		}
		
		guard let data = data, let urlResponse = urlResponse else {
			// Default fallback if mock isn't configured, helps avoid crashes in empty tests
			throw NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock not configured"])
		}
		
		return (data, urlResponse)
	}
	
	// MARK: - Configuration Helpers
	
	static func withSuccessResponse(url: URL, data: Data, statusCode: Int = 200) -> MockURLSession {
		let mock = MockURLSession()
		mock.data = data
		mock.urlResponse = HTTPURLResponse(
			url: url,
			statusCode: statusCode,
			httpVersion: nil,
			headerFields: nil
		)
		return mock
	}
	
	static func withNonHTTPResponse(url: URL, data: Data) -> MockURLSession {
		let mock = MockURLSession()
		mock.data = data
		mock.urlResponse = URLResponse(
			url: url,
			mimeType: "text/html",
			expectedContentLength: data.count,
			textEncodingName: nil
		)
		return mock
	}
	
	static func withError(error: Error) -> MockURLSession {
		let mock = MockURLSession()
		mock.error = error
		return mock
	}
}
