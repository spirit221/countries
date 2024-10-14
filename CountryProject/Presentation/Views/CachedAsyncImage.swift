//
//  CachedAsyncImage.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import SwiftUI

// MARK: - Image Cache
class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func get(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}

// MARK: - CachedAsyncImage View
struct CachedAsyncImage<Content: View>: View {
    @StateObject private var loader: ImageLoader
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: String?,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.content = content
    }
    
    var body: some View {
        content(loader.phase)
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }
}

// MARK: - ImageLoader with Async/Await
@MainActor
class ImageLoader: ObservableObject {
    @Published var phase: AsyncImagePhase = .empty
    private let getFlagUseCase: GetFlagUseCase
    private let url: String?
    private var task: Task<Void, Never>?
    
    init(
        url: String?,
        getFlagUseCase: GetFlagUseCase = DependencyContainer.shared.getFlagUseCase
    ) {
        self.url = url
        self.getFlagUseCase = getFlagUseCase
    }
    
    func load() {
        guard let url = url else {
            phase = .empty
            return
        }
        
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            phase = .success(Image(uiImage: cachedImage))
            return
        }
        
        task = Task {
            do {
                let uiImage = try await getFlagUseCase.execute(url)
                ImageCache.shared.set(uiImage, forKey: url)
                phase = .success(Image(uiImage: uiImage))
            } catch {
                phase = .empty
            }
        }
    }
    
    func cancel() {
        task?.cancel()
        task = nil
    }
}

// MARK: - AsyncImagePhase Definition
enum AsyncImagePhase {
    case empty
    case success(Image)
}
