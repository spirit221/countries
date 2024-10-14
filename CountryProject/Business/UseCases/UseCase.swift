//
//  UseCase.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

protocol UseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(_ input: Input) async throws -> Output
}

extension UseCase where Input == Void {
    func execute() async throws -> Output {
        return try await execute(())
    }
}
