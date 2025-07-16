//
//  PokeView.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import SwiftUI

struct PokeView: View {

    @StateObject var viewModel: PokeViewModel
    @State private var rotation = 0.0
    @State private var isVisible: Bool = true
    @State private var offsetY: CGFloat = 0
    @State private var offsetX: CGFloat = 0
    @State private var scale: CGFloat = 1
    @State private var rotationAxis: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 0, 0)

    var body: some View {

        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.brown.opacity(0.2))
            VStack {
                Spacer()
                Group{
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(radius: 8)
                    VStack {
                        Spacer()
                        AsyncImage(
                            url: URL(
                                string: viewModel.pokemon?.sprites.front_default
                                    ?? "")
                        ) { image in
                            image.resizable()
                                .interpolation(.none)
                                .scaledToFit()
                        } placeholder: {
                            Color.white
                        }
                        Spacer()
                        Text(viewModel.pokemon?.name ?? "Test")
                            .font(.system(size: 24))
                            .padding()
                    }
                    .padding()
                }
                .frame(width: 300, height: 500)
                }
                .offset(y: offsetY)
                .offset(x: offsetX)
                .rotation3DEffect(.degrees(rotation),axis: (rotationAxis))
                .animation(.easeInOut(duration: 1.2), value: rotation)
                .opacity(isVisible ? 1 : 0)
                .scaleEffect(scale)

                Spacer()
                Button {
                    rotationAxis = ((Bool.random() ? 1 : -1), (Bool.random() ? 1 : -1), (Bool.random() ? 1 : -1))
                    runSequence()
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

    func runSequence() {
        withAnimation(.easeOut(duration: 0.2)) {
            isVisible = false
            offsetX = 400
        }
        
        Task {
            
            try await viewModel.fetchRandomPokemon()
            offsetX = 0
            scale = 0.1
            rotation += 1080

            try? await Task.sleep(nanoseconds: 300_000_000)
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.3)) {
                isVisible = true
            }
            withAnimation(.easeInOut(duration: 1.0)) {
                scale = 1
            }
        }
    }

}

#Preview {
    PokeView(viewModel: PokeViewModel())
}
