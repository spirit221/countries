//
//  GetAllCountriesUseCase.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

struct GetAllCountriesUseCase: UseCase {
    typealias Input = Void
    typealias Output = [CountryListItem]
    
    private let repository: CountryRepository
    
    init(repository: CountryRepository) {
        self.repository = repository
    }
    
    func execute(_ input: Void) async throws -> [CountryListItem] {
        return try await repository.getAllCountries()
    }
}
