//
//  GetCountryDetailUseCaseTests.swift
//  CountryProjectTests
//
//  Created by Sergey Gusev on 13.10.2024.
//

import XCTest
@testable import CountryProject

class GetCountryDetailUseCaseTests: XCTestCase {
    
    var useCase: GetCountryDetailUseCase!
    var mockRepository: MockCountryRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCountryRepository()
        useCase = GetCountryDetailUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecute_Success() async throws {
        // Given
        let countryCode = "US"
        let expectedDetail = MockModels.countryDetail
        mockRepository.mockCountryDetail = expectedDetail
        
        // When
        let result = try await useCase.execute(countryCode)
        
        // Then
        XCTAssertEqual(result, expectedDetail)
        XCTAssertEqual(mockRepository.getCountryDetailCallCount, 1)
        XCTAssertEqual(mockRepository.lastRequestedCode, countryCode)
    }
    
    func testExecute_Error() async {
        // Given
        let countryCode = "INVALID"
        let expectedError = NetworkError.invalidResponse
        mockRepository.mockError = expectedError
        
        // When/Then
        do {
            _ = try await useCase.execute(countryCode)
            XCTFail("Expected error, but got success")
        } catch {
            XCTAssertEqual(error as? NetworkError, expectedError)
            XCTAssertEqual(mockRepository.getCountryDetailCallCount, 1)
            XCTAssertEqual(mockRepository.lastRequestedCode, countryCode)
        }
    }
}
