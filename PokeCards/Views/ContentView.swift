//
//  ContentView.swift
//  PokeCards
//
//  Created by Nathaniel Bedggood on 15/07/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    

    var body: some View {
        PokeView(viewModel: PokeViewModel())
    }
}

#Preview {
    ContentView()
}
