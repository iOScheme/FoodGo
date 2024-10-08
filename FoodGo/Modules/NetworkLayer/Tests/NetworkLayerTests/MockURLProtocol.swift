//
//  File.swift
//  NetworkLayer
//
//  Created by Alex.personal on 8/10/24.
//

import Foundation
enum MockNetworkError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case serverError // 500
    case unknownError(Int) // For other status codes

    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad Request (400)"
        case .unauthorized:
            return "Unauthorized (401)"
        case .forbidden:
            return "Forbidden (403)"
        case .notFound:
            return "Not Found (404)"
        case .serverError:
            return "Internal Server Error (500)"
        case .unknownError(let code):
            return "Unknown Error (\(code))"
        }
    }
}


class MockURLProtocol: URLProtocol {
    static var error: Error?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        guard let handler = MockURLProtocol.requestHandler else {
            assertionFailure("Received unexpected request with no handler set")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            
            // Check for HTTP status code errors
             let httpResponse = response as HTTPURLResponse
                switch httpResponse.statusCode {
                case 200..<300:
                    // Success response
                    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                    client?.urlProtocol(self, didLoad: data)
                case 400:
                    throw MockNetworkError.badRequest
                case 401:
                    throw MockNetworkError.unauthorized
                case 403:
                    throw MockNetworkError.forbidden
                case 404:
                    throw MockNetworkError.notFound
                case 500:
                    throw MockNetworkError.serverError
                default:
                    throw MockNetworkError.unknownError(httpResponse.statusCode)
                }
            
            
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        // Stop loading implementation
    }
}
