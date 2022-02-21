//
//  NetworkError.swift
//  nasa-images
//
//  Created by Gabriela Sillis on 21/02/22.
//

enum NetworkError: Error, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return true
    }
    
    case badRequest
    case noData
    case invalidURL
    case custom(error: Error)
    case noConnectivity
}
