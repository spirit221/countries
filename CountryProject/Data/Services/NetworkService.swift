//
//  NetworkService.swift
//  CountryProject
//
//  Created by Sergey Gusev on 13.10.2024.
//

import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(url: URL) async throws -> T
}

class NetworkServiceImpl: NetworkService {
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        if T.self == Data.self, let resultData = data as? T {
            return resultData
        }
        return try decoder.decode(T.self, from: data)
    }
}
