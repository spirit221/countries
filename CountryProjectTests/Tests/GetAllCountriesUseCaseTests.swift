//
//  GetAllCountriesUseCaseTests.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import XCTest
@testable import CountryProject

class GetAllCountriesUseCaseTests: XCTestCase {
    
    var useCase: GetAllCountriesUseCase!
    var mockRepository: MockCountryRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCountryRepository()
        useCase = GetAllCountriesUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecute_Success() async throws {
        // Given
        let expectedCountries = [MockModels.usCountryListItem, MockModels.caCountryListItem]
        mockRepository.mockCountries = expectedCountries
        
        // When
        let result = try await useCase.execute()
        
        // Then
        XCTAssertEqual(result.first, expectedCountries.first)
        XCTAssertEqual(mockRepository.getAllCountriesCallCount, 1)
    }
    
    func testExecute_EmptyList() async throws {
        // Given
        mockRepository.mockCountries = []
        
        // When
        let result = try await useCase.execute()
        
        // Then
        XCTAssertTrue(result.isEmpty)
        XCTAssertEqual(mockRepository.getAllCountriesCallCount, 1)
    }
    
    func testExecute_NetworkError() async {
        // Given
        mockRepository.mockError = NSError(domain: "NetworkError", code: -1, userInfo: nil)
        
        // When/Then
        do {
            _ = try await useCase.execute()
            XCTFail("Expected error, but got success")
        } catch {
            XCTAssertNotNil(error)
            XCTAssertEqual(mockRepository.getAllCountriesCallCount, 1)
        }
    }
    
    func testExecute_CorrectOrder() async throws {
        // Given
        let countries = [
            MockModels.caCountryListItem,
            MockModels.usCountryListItem,
            MockModels.jpCountryListItem
        ]
        mockRepository.mockCountries = countries
        
        // When
        let result = try await useCase.execute()
        
        // Then
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(result[0].id, "CA")
        XCTAssertEqual(result[1].id, "US")
        XCTAssertEqual(result[2].id, "JP")
    }
}
