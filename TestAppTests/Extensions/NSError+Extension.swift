//
//  NSError+Extension.swift
//  TestApp
//
//  Created by Mircea Ghenciu on 09.12.2025.
//


import Foundation

private extension NSError {
	static let testError = NSError(domain: "TestError", code: 123, userInfo: nil)
	static let internetOfflineError = NSError(domain: "NSURLErrorDomain", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
}
