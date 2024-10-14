//
//  CountryDetailViewModel.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

class CountryDetailViewModel: ObservableObject {
    @Published var countryListItem: CountryListItem
    @Published var countryDetail: CountryDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getCountryDetailUseCase: GetCountryDetailUseCase
    
    init(
        countryListItem: CountryListItem,
        getCountryDetailUseCase: GetCountryDetailUseCase = DependencyContainer.shared.getCountryDetailUseCase
    ) {
        self.countryListItem = countryListItem
        self.getCountryDetailUseCase = getCountryDetailUseCase
    }
    
    @MainActor
    func fetchCountryDetail() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedCountryDetail = try await getCountryDetailUseCase.execute(countryListItem.id)
                self.countryDetail = fetchedCountryDetail
                self.isLoading = false
            } catch {
                self.errorMessage = error.userFriendlyMessage
                self.isLoading = false
            }
        }
    }
    
    var mapItems: [InfoRow] {
        guard let countryDetail = countryDetail else { return [] }
        return [
            InfoRow(title: "Google Maps", value: countryDetail.maps.googleMaps),
            InfoRow(title: "Open Street Map", value: countryDetail.maps.openStreetMaps)
        ]
    }
    
    var nativeName: String? {
        return countryDetail?.name.nativeName?.values.first?.official
    }
    
    var flag: String {
        return countryListItem.flags.png
    }
    
    var officialName: String {
        return countryListItem.name.official
    }
    
    func getInfo(for countryInfo: CountryInfo) -> [InfoRow] {
        return countryInfo.getInfo(for: countryDetail)
    }
}
