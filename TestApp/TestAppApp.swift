//
//  TestAppApp.swift
//  TestApp
//

import SwiftUI

@main
struct TestAppApp: App {
	@State private var container = AppContainer()

    var body: some Scene {
        WindowGroup {
					CharacterListView(
						viewModel: container.makeCharacterListViewModel()
					)
        }
    }
}

@MainActor
final class AppContainer {
	let httpClient: HTTPClient
	
	init() {
		self.httpClient = URLSessionHTTPClient(
			baseURL: ApiConstants.baseURL,
			session: URLSession(configuration: .ephemeral)
		)
	}
	
	func makeCharacterListViewModel() -> CharacterListViewModel {
		return CharacterListViewModel(httpClient: httpClient)
	}
}
