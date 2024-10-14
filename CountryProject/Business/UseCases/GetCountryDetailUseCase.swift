//
//  GetCountryDetailUseCase.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

struct GetCountryDetailUseCase: UseCase {
    typealias Input = String
    typealias Output = CountryDetail
    
    private let repository: CountryRepository
    
    init(repository: CountryRepository) {
        self.repository = repository
    }
    
    func execute(_ input: String) async throws -> CountryDetail {
        return try await repository.getCountryDetail(code: input)
    }
}
