//
//  CountryListViewModel.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

class CountryListViewModel: ObservableObject {
    @Published var countries: [CountryListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    
    private let getAllCountriesUseCase: GetAllCountriesUseCase
    
    init(
        getAllCountriesUseCase: GetAllCountriesUseCase = DependencyContainer.shared.getAllCountriesUseCase
    ) {
        self.getAllCountriesUseCase = getAllCountriesUseCase
        
        Task {
            await fetchCountries()
        }
    }
    
    var filteredCountries: [CountryListItem] {
        return countries
            .filter {
                self.searchText.isEmpty
                    ? true :
                    $0.name.common.localizedCaseInsensitiveContains(searchText)
            }
    }
    
    @MainActor
    func fetchCountries() {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let fetchedCountries = try await getAllCountriesUseCase.execute()
                self.countries = fetchedCountries
                self.isLoading = false
            } catch {
                self.errorMessage = error.userFriendlyMessage
                self.isLoading = false
            }
        }
    }
}
