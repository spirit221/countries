//
//  GetFlagUseCase.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import UIKit

enum ImageError: Error {
    case invalidImageData
}

struct GetFlagUseCase: UseCase {
    typealias Input = String
    typealias Output = UIImage
    
    private let repository: FlagRepository
    
    init(repository: FlagRepository) {
        self.repository = repository
    }
    
    func execute(_ input: String) async throws -> UIImage {
        let data = try await repository.getFlag(url: input)
        
        guard let image = UIImage(data: data) else {
            throw ImageError.invalidImageData
        }
        
        return image
    }
}
