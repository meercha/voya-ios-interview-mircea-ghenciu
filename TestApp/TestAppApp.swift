//
//  TestAppApp.swift
//  TestApp
//

import SwiftUI

@main
struct TestAppApp: App {
    let characterListViewModel = CharacterListViewModel()

    var body: some Scene {
        WindowGroup {
            CharacterListView(viewModel: characterListViewModel)
        }
    }
}
