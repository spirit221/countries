//
//  MockFlagRepository.swift
//  CountryProjectTests
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

class MockFlagRepository: FlagRepository {
    var shouldSucceed = true
    var mockData: Data?
    
    func getFlag(url: String) async throws -> Data {
        if shouldSucceed {
            return mockData ?? Data()
        } else {
            throw NetworkError.invalidURL
        }
    }
}
