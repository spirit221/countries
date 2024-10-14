//
//  CountryRepository.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

protocol CountryRepository {
    func getAllCountries() async throws -> [CountryListItem]
    func getCountryDetail(code: String) async throws -> CountryDetail
}

class CountryRepositoryImpl: CountryRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getAllCountries() async throws -> [CountryListItem] {
        guard let url = URL(string: APIConstants.allCountriesEndpoint) else {
            throw NetworkError.invalidURL
        }
        return try await networkService.fetch(url: url)
    }
    
    func getCountryDetail(code: String) async throws -> CountryDetail {
        guard let url = URL(string: APIConstants.countryDetailEndpoint + code) else {
            throw NetworkError.invalidURL
        }
        let countryDetails: [CountryDetail] = try await networkService.fetch(url: url)
        
        guard let firstDetail = countryDetails.first else {
            throw NetworkError.emptyResponse
        }
        
        return firstDetail
    }
}
