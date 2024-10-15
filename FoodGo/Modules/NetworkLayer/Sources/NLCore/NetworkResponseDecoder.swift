//
//  NetworkResponseDecoder.swift
//  NetworkLayer
//
//  Created by Alex.personal on 15/10/24.
//
import Foundation

protocol NetworkResponseJsonDecoder {
    func jsonDecoder<T: Decodable>(from: Data, to: T.Type) throws -> T
}

final class NetworkResponseDecoder {
    private let decoder = JSONDecoder()
    init() {}
}

extension NetworkResponseDecoder: NetworkResponseJsonDecoder {
    public func jsonDecoder<T>(from data: Data, to type: T.Type) throws -> T where T : Decodable {
        try decoder.decode(type, from: data)
    }
}
