//
//  SkeletonModifier.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import SwiftUI

struct SkeletonModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
                .shimmering()
        } else {
            content
        }
    }
}

struct Shimmering: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .modifier(ShimmeringHelper(phase: phase))
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    self.phase = 1
                }
            }
    }
}

struct ShimmeringHelper: AnimatableModifier {
    var phase: CGFloat
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    Color.white
                        .opacity(0.3)
                        .mask(
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.clear, .white, .clear]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .rotationEffect(.init(degrees: 70))
                                .offset(x: -geometry.size.width + (geometry.size.width * 2 * phase))
                        )
                }
            )
            .mask(content)
    }
}

extension View {
    func shimmering() -> some View {
        modifier(Shimmering())
    }
    
    func skeleton(isLoading: Bool) -> some View {
        modifier(SkeletonModifier(isLoading: isLoading))
    }
}
