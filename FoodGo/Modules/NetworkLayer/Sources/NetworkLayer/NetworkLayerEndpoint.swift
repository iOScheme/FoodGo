//
//  File.swift
//  NetworkLayer
//
//  Created by Alex.personal on 2/10/24.
//

import Foundation

public protocol NetworkLayerEndpoint {
    var queryItems: [URLQueryItem] { get set}
    var path: String { get set}
    var method: URLRequestMethod { get set }
    var asURLRequest: URLRequest? { get set }
    var basePath: String { get set }
}

extension NetworkLayerEndpoint {
    var basePath: String {
        NetworkLayerConfig.basePath
    }
    
    var asURLRequest: URLRequest? {
        var urlComponent = URLComponents()
        urlComponent.host = basePath
        urlComponent.path = path
        urlComponent.queryItems = queryItems
        guard let url = urlComponent.url else { return nil }
        return URLRequest(url: url)
    }
}

public enum URLRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
