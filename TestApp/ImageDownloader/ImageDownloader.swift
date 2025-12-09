//
//  ImageDownloader.swift
//  TestApp
//

import UIKit

enum ImageDownloaderError: Error {
    case requestError
    case invalidResponse
}

protocol ImageDownloader {
    func downloadImage(from url: URL) async throws -> UIImage
}

final class DefaultImageDownloader: ImageDownloader {
    private let cache = DefaultImageCache()
    
    func downloadImage(from url: URL) async throws -> UIImage {
        // TODO
        return UIImage()
    }
}
