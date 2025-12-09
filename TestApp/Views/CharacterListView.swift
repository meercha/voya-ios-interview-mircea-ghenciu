//
//  CharacterListView.swift
//  TestApp
//

import SwiftUI

struct CharacterListView: View {
	let viewModel: CharacterListViewModel
	
	var body: some View {
		VStack {
			// Show error if initial load failed
			
			VStack {
				switch viewModel.state {
				case .loading:
					ProgressView("Loading Characters...")
						.controlSize(.large)
					
				case .error(let message):
					ContentUnavailableView("Error", systemImage: "exclamationmark.triangle", description: Text(message))
						.onTapGesture {
							Task { await viewModel.fetchCharacters() }
						}
					
				case .empty:
					ContentUnavailableView("No characters found", systemImage: "person.3.sequence")
						.onTapGesture {
							Task { await viewModel.fetchCharacters() }
						}
					
				case .idle, .loadingMore:
					characterList(viewModel.characters)
				}
			}
			.task {
				if viewModel.characters.isEmpty {
					await viewModel.fetchCharacters()
				}
			}
		}
	}
	
	@ViewBuilder func characterList(_ characters: [Character]) -> some View {
		List(Array(characters.enumerated()), id: \.offset) { index, character in
			CharacterView(character: character)
				.padding(.horizontal)
				.onAppear {
					if index == viewModel.characters.count - 3 {
						Task {
							await viewModel.fetchCharacters()
						}
					}
				}
			
			if viewModel.state == .loadingMore {
				ProgressView()
					.frame(maxWidth: .infinity)
					.padding()
			}
		}
	}
}
