//
//  DependencyContainer.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

class DependencyContainer {
    static let shared = DependencyContainer()
    
    lazy var networkService: NetworkService = NetworkServiceImpl()
    lazy var countryRepository: CountryRepository = CountryRepositoryImpl(networkService: networkService)
    lazy var flagRepository: FlagRepository = FlagRepositoryImpl(networkService: networkService)
    lazy var getAllCountriesUseCase: GetAllCountriesUseCase = GetAllCountriesUseCase(repository: countryRepository)
    lazy var getCountryDetailUseCase: GetCountryDetailUseCase = GetCountryDetailUseCase(repository: countryRepository)
    lazy var getFlagUseCase: GetFlagUseCase = GetFlagUseCase(repository: flagRepository)
    
    private init() {}
}
