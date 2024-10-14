//
//  GetFlagUseCaseTests.swift
//  CountryProjectTests
//
//  Created by Sergey Gusev on 13.10.2024.
//

import XCTest
@testable import CountryProject

class GetFlagUseCaseTests: XCTestCase {
    
    var useCase: GetFlagUseCase!
    var mockRepository: MockFlagRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockFlagRepository()
        useCase = GetFlagUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testGetFlagSuccess() async throws {
        // Given
        let expectedImage = UIImage(systemName: "flag")!
        let imageData = expectedImage.pngData()!
        mockRepository.mockData = imageData
        
        // When
        let result = try await useCase.execute("https://example.com/flag.png")
        
        // Then
        XCTAssertNotNil(result)
    }
    
    func testGetFlagFailureInvalidURL() async {
        // Given
        mockRepository.shouldSucceed = false
        
        // When/Then
        do {
            _ = try await useCase.execute("invalid-url")
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(error as? NetworkError, .invalidURL)
        }
    }
    
    func testGetFlagFailureInvalidImageData() async {
        // Given
        mockRepository.mockData = Data("invalid image data".utf8)
        
        // When/Then
        do {
            _ = try await useCase.execute("https://example.com/flag.png")
            XCTFail("Expected to throw an error")
        } catch {
            XCTAssertTrue(error is ImageError)
            XCTAssertEqual(error as? ImageError, .invalidImageData)
        }
    }
}
