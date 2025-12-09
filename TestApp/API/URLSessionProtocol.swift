//
//  URLSessionProtocol.swift
//  TestApp
//
//  Created by Mircea Ghenciu on 09.12.2025.
//


import Foundation

protocol URLSessionProtocol {
		func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
