//
//  CharacterListView.swift
//  TestApp
//

import SwiftUI

struct CharacterListView: View {
    let viewModel: CharacterListViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                Text("Error: \(error)")
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.characters, id: \.id) { character in
                            CharacterView(character: character)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchCharacters()
        }
    }
}
