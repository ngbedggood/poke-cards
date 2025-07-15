//
//  PokeView.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import SwiftUI


struct PokeView: View {
    
    @StateObject var viewModel: PokeViewModel
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.brown.opacity(0.2))
            VStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                    VStack {
                        AsyncImage(url: URL(string: viewModel.pokemon?.sprites.front_default ?? "")) { image in
                            image.resizable()
                                .scaledToFit()
                        } placeholder: {
                            Color.white
                        }
                        .clipShape(.rect(cornerRadius: 20))
                        Text(viewModel.pokemon?.name ?? "Test")
                            .font(.title)
                            .padding()
                    }
                }
                .frame(width: 300, height: 500)
                Spacer()
                Button {
                    viewModel.fetchDitto()
                } label: {
                    Text("Random Pokemon")
                }
                .buttonStyle(.borderedProminent)
                .font(.title)
                .tint(.gray)
                .frame(height: 80)
                Spacer()

            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    PokeView(viewModel: PokeViewModel())
}
