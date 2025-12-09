//
//  CharacterView.swift
//  TestApp
//

import SwiftUI

struct CharacterView: View {
    let character: Character

    var body: some View {
        HStack {
            if let imageURL = URL(string: character.image) {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                Text("Species: \(character.species)")
            }

            Spacer()
        }
    }
}
