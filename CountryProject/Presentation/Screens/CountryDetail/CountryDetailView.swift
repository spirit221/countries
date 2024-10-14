//
//  CountryDetailView.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import SwiftUI

struct CountryDetailView: View {
    @Environment(\.openURL) var openURL
    
    @ObservedObject private var viewModel: CountryDetailViewModel
    
    @State private var selectedTab: CountryInfo = .general
    
    init(countryListItem: CountryListItem) {
        viewModel = CountryDetailViewModel(countryListItem: countryListItem)
    }
    
    var body: some View {
        baseView()
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchCountryDetail()
            }
            .errorAlert(errorMessage: $viewModel.errorMessage)
    }
    
    @ViewBuilder
    private func baseView() -> some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection()
                if viewModel.isLoading  {
                    skeletons()
                } else {
                    tabView()
                    selectedTabContent()
                }
            }
            .padding()
            .padding(.bottom, 100)
        }
        .overlay(alignment: .bottom) {
            mapButtons()
        }
    }
    
    @ViewBuilder
    private func skeletons() -> some View {
        SkeletonView()
            .frame(height: 40)
        SkeletonView()
            .frame(height: 200)
    }
    
    @ViewBuilder
    private func headerSection() -> some View {
        VStack(spacing: 8) {
            countryImage(viewModel.flag)
            
            Text(viewModel.officialName)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
            
            if let nativeName = viewModel.nativeName {
                Text(nativeName)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func countryImage(_ imageUrl: String) -> some View {
        CachedAsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                SkeletonView()
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .frame(height: 200)
    }
    
    @ViewBuilder
    private func tabView() -> some View {
        Picker("", selection: $selectedTab) {
            ForEach(CountryInfo.allCases) {
                Text($0.title).tag($0)
            }
        }
        .pickerStyle(.segmented)
    }
    
    @ViewBuilder
    private func selectedTabContent() -> some View {
        sectionView(viewModel.getInfo(for: selectedTab))
    }
    
    @ViewBuilder
    private func sectionView(_ infoRows: [InfoRow]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(infoRows, id: \.title) { info in
                infoRow(title: info.title, value: info.value)
            }
        }
        .padding()
        .cardBackground()
    }
    
    @ViewBuilder
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
    
    @ViewBuilder
    private func mapButtons() -> some View {
        HStack {
            ForEach(viewModel.mapItems, id: \.title) { item in
                mapButton(infoRow: item)
            }
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func mapButton(infoRow: InfoRow) -> some View {
        Button(action: {
            guard let url = URL(string: infoRow.value) else {
                return
            }
            openURL(url)
        }) {
            Text(infoRow.title)
                .padding(8)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(.cyan)
                .cornerRadius(25)
        }
    }
}

#Preview {
    CountryDetailView(
        countryListItem: .init(
            id: "us",
            name: .init(
                common: "USA",
                official: "USA",
                nativeName: nil
            ),
            flags: .init(
                png: "https://flagcdn.com/w320/us.png",
                svg: "",
                alt: nil
            )
        )
    )
}
