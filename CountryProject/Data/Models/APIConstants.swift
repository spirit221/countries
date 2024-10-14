//
//  APIConstants.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

struct APIConstants {
    static let baseURL = "https://restcountries.com/v3.1"
    static let allCountriesEndpoint = "\(baseURL)/all?fields=name,flags,cca2"
    static let countryDetailEndpoint = "\(baseURL)/alpha/"
}
