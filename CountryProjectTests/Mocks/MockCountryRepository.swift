//
//  MockCountryRepository.swift
//  CountryProjectTests
//
//  Created by Sergey Gusev on 13.10.2024.
//

class MockCountryRepository: CountryRepository {
    var mockCountryDetail: CountryDetail?
    var mockCountries: [CountryListItem] = []
    var mockError: Error?
    var getCountryDetailCallCount = 0
    var getAllCountriesCallCount = 0
    var lastRequestedCode: String?
    
    func getAllCountries() async throws -> [CountryListItem] {
        getAllCountriesCallCount += 1
        if let error = mockError {
            throw error
        }
        return mockCountries
    }
    
    func getCountryDetail(code: String) async throws -> CountryDetail {
        getCountryDetailCallCount += 1
        lastRequestedCode = code
        if let error = mockError {
            throw error
        }
        return mockCountryDetail ?? MockModels.countryDetail
    }
}
