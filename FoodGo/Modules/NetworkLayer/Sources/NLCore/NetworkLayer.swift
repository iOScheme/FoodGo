// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public protocol UrlResponseHandlerDelegate: AnyObject {
    func handle(response: URLResponse)
}

public protocol NetworkLayerProtocol {
    func execute<T: Decodable>(request: URLRequest, dto: T.Type)  async throws -> T
}

public final class NetworkLayer: NetworkLayerProtocol {
    private let networkLayerCore: NetworkLayerCoreProtocol
    private let decoder: NetworkResponseJsonDecoder = NetworkResponseDecoder()
    
    private weak var urlResponseHandlerDelegate: UrlResponseHandlerDelegate?
    
    public init(networkLayerCore: NetworkLayerCoreProtocol) {
        self.networkLayerCore = networkLayerCore
    }
    
    public func execute<T: Decodable>(request: URLRequest, dto: T.Type) async throws -> T {
        let (data, urlResponse) = try await networkLayerCore.execute(request: request)
        urlResponseHandlerDelegate?.handle(response: urlResponse)
        return try decoder.jsonDecoder(from: data, to: dto)
    }
}


