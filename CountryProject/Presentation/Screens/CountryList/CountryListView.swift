//
//  CountryListView.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject private var viewModel = CountryListViewModel()
    
    var body: some View {
        NavigationView {
            baseView()
                .navigationTitle("Countries")
                .searchable(text: $viewModel.searchText)
                .errorAlert(errorMessage: $viewModel.errorMessage)
        }
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.fixed((width / 2) - 24), spacing: 16),
                    GridItem(.fixed((width / 2) - 24))
                ], spacing: 16) {
                    contentView()
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        if viewModel.isLoading {
            ForEach(0..<10, id:\.self) { _ in
                SkeletonView()
                    .frame(height: 110)
            }
        } else {
            ForEach(viewModel.filteredCountries) { country in
                countryItem(item: country)
            }
        }
    }
    
    @ViewBuilder
    private func countryItem(item: CountryListItem) -> some View {
        NavigationLink(destination: CountryDetailView(countryListItem: item)) {
            VStack {
                CachedAsyncImage(url: item.flags.png) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.1)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(height: 60)
                .cornerRadius(8)
                
                Text(item.name.common)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 110)
            .frame(maxWidth: .infinity)
            .padding()
            .cardBackground()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .buttonStyle(.plain)
    }
    
}

#Preview {
    CountryListView()
}
