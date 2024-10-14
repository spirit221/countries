//
//  CardBackgroundModifier.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import SwiftUI

struct CardBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: 16))
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        .thinMaterial
                            .shadow(.drop(color: .black.opacity(0.08), radius: 2, x: 2, y: 2))
                            .shadow(.drop(color: .black.opacity(0.05), radius: 2, x: -2, y: -2))
                    )
            }
    }
}

extension View {
    func cardBackground() -> some View {
        self.modifier(CardBackgroundModifier())
    }
}
