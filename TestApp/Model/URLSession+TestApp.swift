//
//  URLSession+TestApp.swift
//  TestApp
//

import Foundation

extension URLSession {
    static let testApp = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
}
