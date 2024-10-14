//
//  FlagRepository.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import SwiftUI

protocol FlagRepository {
    func getFlag(url: String) async throws -> Data
}

class FlagRepositoryImpl: FlagRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getFlag(url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        return try await networkService.fetch(url: url)
    }
}
