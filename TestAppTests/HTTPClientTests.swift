//
//  HTTPClientTests.swift
//  TestApp
//
//  Created by Mircea Ghenciu on 09.12.2025.
//


import Testing
import Foundation
import TestApp

struct HTTPClientTests {
	
	static let baseURL = URL(string: "https://rickandmortyapi.com/api")!
	
	struct MockResponse: Codable, Equatable {
		let id: Int
		let name: String
	}
	
	var sut: URLSessionHTTPClient!
	
	@Test mutating func test_successful_request_and_decoding() async throws {
		// Arrange
		let expectedObject = MockResponse(id: 1, name: "Rick")
		let responseData = try JSONEncoder().encode(expectedObject)
		
		let session = MockURLSession.withSuccessResponse(url: Self.baseURL, data: responseData)
		sut = URLSessionHTTPClient(baseURL: Self.baseURL, session: session)
		
		// Act
		let result: MockResponse = try await sut.sendRequest(endpoint: .characters(page: 1))
		
		// Assert
		#expect(result == expectedObject)
		
		// Verify the client constructed the URL correctly
		let capturedUrl = session.lastRequest?.url?.absoluteString
		#expect(capturedUrl?.contains("/character") == true)
		#expect(capturedUrl?.contains("page=1") == true)
	}
	
	@Test mutating func test_request_failure_invalid_status_code() async throws {
		// Arrange
		let data = Data()
		let session = MockURLSession.withSuccessResponse(url: Self.baseURL, data: data, statusCode: 404)
		sut = URLSessionHTTPClient(baseURL: Self.baseURL, session: session)
		
		// Act & Assert
		do {
			let _: MockResponse = try await sut.sendRequest(endpoint: .userDetails)
			Issue.record("Expected invalidResponse error but request succeeded")
		} catch let error as APIClientError {
			if case .invalidResponse = error {
				// Success
			} else {
				Issue.record("Expected invalidResponse, but got \(error)")
			}
		} catch {
			Issue.record("Unexpected error type: \(error)")
		}
	}
	
	@Test mutating func test_request_failure_non_http_response() async {
		// Arrange
		let data = Data()
		let session = MockURLSession.withNonHTTPResponse(url: Self.baseURL, data: data)
		sut = URLSessionHTTPClient(baseURL: Self.baseURL, session: session)
		
		// Act & Assert
		do {
			let _: MockResponse = try await sut.sendRequest(endpoint: .userDetails)
			Issue.record("Expected notHTTPResponse error")
		} catch let error as APIClientError {
			if case .invalidResponse = error {
				// Success
			} else {
				Issue.record("Expected notHTTPResponse, but got \(error)")
			}
		} catch {
			Issue.record("Unexpected error type: \(error)")
		}
	}
	
	@Test mutating func test_request_decoding_error() async throws {
		// Arrange
		let invalidJson = "{\"wrong_key\": \"value\"}".data(using: .utf8)!
		let session = MockURLSession.withSuccessResponse(url: Self.baseURL, data: invalidJson)
		sut = URLSessionHTTPClient(baseURL: Self.baseURL, session: session)
		
		// Act & Assert
		do {
			let _: MockResponse = try await sut.sendRequest(endpoint: .userDetails)
			Issue.record("Expected decodingError")
		} catch let error as APIClientError {
			if case .decodingError = error {
				// Success
			} else {
				Issue.record("Expected decodingError, but got \(error)")
			}
		} catch {
			Issue.record("Unexpected error type: \(error)")
		}
	}
}
