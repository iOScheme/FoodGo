//
//  File.swift
//  NetworkLayer
//
//  Created by Alex.personal on 2/10/24.
//

import Foundation

public protocol NetworkLayerEndpoint {
    var queryItems: [URLQueryItem] { get}
    var path: String { get }
    var method: URLRequestMethod { get }
    var asURLRequest: URLRequest? { get }
    var basePath: String { get }
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
        urlComponent.scheme = "https"
       
        guard let url = urlComponent.url else { return nil }
        var  request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

public enum URLRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
