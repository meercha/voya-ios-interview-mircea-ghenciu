//
//  HTTPMethod.swift
//  TestApp
//
//  Created by Mircea Ghenciu on 09.12.2025.
//


import Foundation

enum HTTPMethod: String {
	case get
	case post
	
	var stringValue: String {
		return rawValue.uppercased()
	}
}

enum Endpoint {
	case characters(page: Int)
	case userDetails
	
	var method: HTTPMethod {
		switch self {
		case .characters:
			return .get
		case .userDetails:
			return .post
		}
	}
	
	var path: String {
		switch self {
		case .characters:
			return "character"
		case .userDetails:
			return "user"
		}
	}
	
	var queryParameters: [URLQueryItem]? {
		switch self {
		case .characters(let page):
			return [URLQueryItem(name: "page", value: "\(page)")]
		case .userDetails:
			return [URLQueryItem(name: "user", value: "test")]
		}
	}
}
